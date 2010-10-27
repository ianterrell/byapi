class Category < ActiveRecord::Base
  has_many :designs
  
  validates_uniqueness_of :key
  validates_uniqueness_of :name
  validates_presence_of :name, :key  
end
