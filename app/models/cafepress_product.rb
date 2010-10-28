class CafepressProduct < ActiveRecord::Base
  belongs_to :design
  belongs_to :product
end
