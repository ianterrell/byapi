class AddPaddingToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :padding, :string
  end

  def self.down
    remove_column :products, :padding
  end
end
