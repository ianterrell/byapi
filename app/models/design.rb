class Design < ActiveRecord::Base
  belongs_to :site
  belongs_to :pattern
  
  serialize :properties
  
  scope :approved, where("approved_at is not null")
  scope :recent, order("approved_at desc")
  scope :best_selling, order("sales_count desc")
end
