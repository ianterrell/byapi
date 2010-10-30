class Site < ActiveRecord::Base
  has_many :patterns
  has_many :designs
  belongs_to :default_category, :class_name => "Category", :foreign_key => "default_category_id"
  belongs_to :current_store, :class_name => "Store", :foreign_key => "current_store_id"
  
  validates_presence_of :title, :domain, :analytics_code
end
