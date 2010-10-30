class AddCustomPriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :custom_price, :string
  end

  def self.down
    remove_column :products, :custom_price
  end
end
