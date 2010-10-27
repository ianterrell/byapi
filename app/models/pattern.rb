class Pattern < ActiveRecord::Base
  belongs_to :site
  
  validates_presence_of :site_id, :name, :view
  validates_length_of :name, :within => 3..64
  validates_length_of :view, :within => 3..32
  
  serialize :properties
  serialize :offsets
  
  has_attached_file :preview, PaperclipStorageHash.merge(:styles => { :medium => ["128x128", :png], :thumb => ["64x64", :png] })
  
  acts_as_taggable
end
