class Design < ActiveRecord::Base
  belongs_to :site
  belongs_to :pattern
  
  serialize :properties
  
  has_attached_file :image, PaperclipStorageHash.merge(:styles => { :large => ["600x600", :png], :medium => ["300x300", :png], :small => ["150x150", :png], :thumb => ["100x100", :png] })
  
  scope :approved, where("approved_at is not null")
  scope :recent, order("approved_at desc")
  scope :best_selling, order("sales_count desc")
  
  def render(options={})
    self.pattern.view.camelize.constantize.new.render(properties, options)
  end
end
