class Pattern < ActiveRecord::Base
  belongs_to :site
  
  validates_presence_of :site_id, :name, :view
  validates_length_of :name, :within => 3..64
  validates_length_of :view, :within => 3..32
  
  serialize :properties
end
