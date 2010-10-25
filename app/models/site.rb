class Site < ActiveRecord::Base
  has_many :patterns
  has_many :designs
  
  validates_presence_of :title, :domain
end
