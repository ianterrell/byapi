class AddMarketplacePriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :marketplace_price, :string
  end

  def self.down
    remove_column :products, :marketplace_price
  end
end
