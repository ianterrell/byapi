class Design < ActiveRecord::Base
  belongs_to :site
  belongs_to :pattern
  
  validates_presence_of :site_id, :pattern_id, :properties, :title
  
  serialize :properties
  
  has_attached_file :image, PaperclipStorageHash.merge(:styles => { :large => ["450x450", :png] })
  
  attr_protected :sales_count, :approved_at
  
  scope :approved, where("approved_at is not null")
  scope :recent, order("approved_at desc")
  scope :best_selling, order("sales_count desc")
  
  def render(options={})
    self.pattern.view.camelize.constantize.new.render(properties, options)
  end
end
