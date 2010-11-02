class AddPrivateToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :private, :boolean, :default => true
  end

  def self.down
    remove_column :sites, :private
  end
end
