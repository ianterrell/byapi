class AddPermissionToUseToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :permission_to_use, :boolean, :default => true
  end

  def self.down
    remove_column :designs, :permission_to_use
  end
end
