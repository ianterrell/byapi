class Product < ActiveRecord::Base
  default_scope order(:position)
  scope :not_ignored, where(:ignored => false)
  
  def price
    custom_price.blank? ? marketplace_price : custom_price
  end
end
