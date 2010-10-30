require 'builder'

class Design < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
  
  belongs_to :site
  belongs_to :pattern
  belongs_to :user
  belongs_to :category
  belongs_to :store
  
  has_many :cafepress_products, :dependent => :destroy
  
  validates_presence_of :site_id, :pattern_id, :category_id, :properties, :title
  
  serialize :properties
  serialize :offsets
  
  has_attached_file :image, PaperclipStorageHash.merge(:styles => { :large => ["450x450", :png], :small => ["150x150", :png] })
  
  attr_protected :sales_count, :approved_at, :cafepress_id, :cafepress_dark_id, :cafepress_media_url, :cafepress_dark_media_url,
    :cafepress_section_id
  
  acts_as_taggable
  
  scope :unapproved, where("approved_at is null and ignored_at is null")
  scope :approved, where("approved_at is not null")
  scope :ignored, where("ignored_at is not null")
  scope :recent, order("approved_at desc")
  scope :best_selling, order("sales_count desc")
  
  def ignored?
    !!ignored_at
  end
  
  def approved?
    !!approved_at
  end
  
  def unapproved?
    !approved?
  end
  
  def approve!
    self.store = site.current_store
    self.approved_at = Time.now
    save
    cafepress!
  end
  
  def reject!
    destroy
  end
  
  def ignore!
    self.update_attribute :ignored_at, Time.now
  end
  
  def render(options={})
    self.pattern.view.camelize.constantize.new.render(properties, options.merge(:offsets => offsets))
  end
  
  def nonblank_offsets
    copy = Marshal.load(Marshal.dump(offsets)) || {}
    copy.each_pair do |key, coordinates|
      coordinates.each_pair do |axis, value|
        coordinates.delete(axis) if value.to_i == 0
      end
    end
    copy
  end
  
  def description
    Liquid::Template.parse(pattern.description).render(properties).gsub('|', ' ')
  end
  
  ###
  ## Cafepress Integration
  #
  
  def cafepress!
    save_to_cafepress
    move_and_tag_designs_in_cafepress
    build_section_in_cafepress
    build_products_in_cafepress
  end
  handle_asynchronously :cafepress! if Rails.env.production?
  
  # Returns true if all design saves are successful.  Could leave orphan designs.  No biggie.
  # Returns nil if it's already been saved.  Pass true to force it to resave.
  def save_to_cafepress(force=false)
    if !force && cafepress_id
      return nil
    end
    success = []
    result = cafepress_client.save_design self
    if result
      self.cafepress_id = result.id
      self.cafepress_media_url = result.media_url
      success << true
    else
      success << false
    end
    if self.pattern.has_dark?
      result = cafepress_client.save_design self, :dark => true
      if result
        self.cafepress_dark_id = result.id
        self.cafepress_dark_media_url = result.media_url
        success << true
      else
        success << false
      end
    end
    [:x, :y, :y_big].each do |padding|
      result = cafepress_client.save_design self, :padding => padding
      if result
        self.send(:"cafepress_id_padded_#{padding}=", result.id)
        success << true
      else
        success << false
      end
    end
    if success.all?{|x|x}
      self.save
      true
    else
      self.reload
      false
    end
  end
  
  def tags_for_cafepress
    (self.tag_list + pattern.tag_list).uniq.join(",")
  end
  
  def move_and_tag_designs_in_cafepress
    cafepress_client.move_and_tag_design self, self.site.domain, self.tags_for_cafepress, self.category.key
  end
  
  def build_section_in_cafepress
    result = cafepress_client.create_section_for_design self
    if result
      self.cafepress_section_id = result.id
      self.save
      true
    else
      false
    end
  end
  
  def build_products_in_cafepress
    cafepress_client.create_products_for_design self
  end
  
  def cafepress_client
    @cafepress_client ||= Cafepress::Client.new.connect!
  end
end
