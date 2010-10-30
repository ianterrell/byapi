class AddIgnoredToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :ignored, :boolean, :default => false
  end

  def self.down
    remove_column :products, :ignored
  end
end
