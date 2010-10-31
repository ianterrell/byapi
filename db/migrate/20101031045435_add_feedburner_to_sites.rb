class AddFeedburnerToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :feedburner, :string
  end

  def self.down
    remove_column :sites, :feedburner
  end
end
