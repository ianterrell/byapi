class Store < ActiveRecord::Base
  has_one :active_site, :class_name => "Site", :foreign_key => "current_store_id"
  has_many :designs
  validates_presence_of :name
end
