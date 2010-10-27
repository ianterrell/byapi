class Site < ActiveRecord::Base
  has_many :patterns
  has_many :designs
  belongs_to :default_category, :class_name => "Category", :foreign_key => "default_category_id"
  
  validates_presence_of :title, :domain
end
