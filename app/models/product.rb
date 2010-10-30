class Product < ActiveRecord::Base
  default_scope order(:position)
end
