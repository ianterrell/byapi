class Design < ActiveRecord::Base
  belongs_to :site
  belongs_to :pattern
  belongs_to :user
  
  validates_presence_of :site_id, :pattern_id, :properties, :title
  
  serialize :properties
  serialize :offsets
  
  has_attached_file :image, PaperclipStorageHash.merge(:styles => { :large => ["450x450", :png] })
  
  attr_protected :sales_count, :approved_at
  
  before_create :auto_approve_if_from_approved_user
  
  scope :approved, where("approved_at is not null")
  scope :recent, order("approved_at desc")
  scope :best_selling, order("sales_count desc")
  
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

protected
  def auto_approve_if_from_approved_user
    if self.user && self.user.approved?
      self.approved_at = Time.now
    end
  end
end
