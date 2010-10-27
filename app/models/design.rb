require 'builder'

class Design < ActiveRecord::Base
  belongs_to :site
  belongs_to :pattern
  belongs_to :user
  belongs_to :category
  belongs_to :store
  
  validates_presence_of :site_id, :pattern_id, :category_id, :properties, :title
  
  serialize :properties
  serialize :offsets
  
  has_attached_file :image, PaperclipStorageHash.merge(:styles => { :large => ["450x450", :png], :small => ["150x150", :png] })
  
  attr_protected :sales_count, :approved_at, :cafepress_id, :cafepress_dark_id, :cafepress_media_url, :cafepress_dark_media_url,
    :cafepress_top_section_id, :cafepress_apparel_section_id, :cafepress_other_section_id
  
  acts_as_taggable
  
  scope :unapproved, where("approved_at is null")
  scope :approved, where("approved_at is not null")
  scope :recent, order("approved_at desc")
  scope :best_selling, order("sales_count desc")
  
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
    # TODO:  add a delayed job to create items in store
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
  
  ###
  ## Cafepress Integration
  #
  
  
  # Returns true if all design saves are successful.  Could leave orphan designs.  No biggie.
  # Returns nil if it's already been saved.  Pass true to force it to resave.
  def save_to_cafepress(force=false)
    if !force && cafepress_id && (!pattern.has_dark? || cafepress_dark_id)
      return nil
    end
    
    success = false
    result = Cafepress::Client.new.save_design self
    if result
      self.cafepress_id = result.id
      self.cafepress_media_url = result.media_url
      success = true
    end
    if self.pattern.has_dark?
      success = false
      result = Cafepress::Client.new.save_design self, :dark => true
      if result
        self.cafepress_dark_id = result.id
        self.cafepress_dark_media_url = result.media_url
        success = true
      end
    end
    self.save
    success
  end
  
  def tags_for_cafepress
    (self.tag_list + pattern.tag_list).uniq.join(",")
  end
  
  def move_and_tag_designs_in_cafepress
    Cafepress::Client.new.move_and_tag_design self, self.site.domain, self.tags_for_cafepress, self.category.key
  end
  
  def build_top_level_section_in_cafepress
    result = Cafepress::Client.new.create_top_level_for_design self
    if result
      self.cafepress_top_section_id = result.id
      self.save
      true
    else
      false
    end
  end
  
  def build_second_level_sections_in_cafepress
    success = false
    result = Cafepress::Client.new.create_second_level_section_for_design self, "Shirts and Apparel"
    if result
      self.cafepress_apparel_section_id = result.id
      result2 = Cafepress::Client.new.create_second_level_section_for_design self, "Mugs, Cards and Lots of Other Stuff"
      if result2
        self.cafepress_other_section_id = result2.id
        success = true
      end
    end
    self.save
    success
  end
end
