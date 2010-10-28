class AddDarkToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :dark, :boolean, :default => false
  end

  def self.down
    remove_column :products, :dark
  end
end
