class AddCategoryIdsToDesignsAndSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :default_category_id, :integer
    add_column :designs, :category_id, :integer
  end

  def self.down
    remove_column :designs, :category_id
    remove_column :sites, :default_category_id
  end
end
