class AddDescriptionToDesigns < ActiveRecord::Migration
  def self.up
    add_column :patterns, :description, :string
  end

  def self.down
    remove_column :patterns, :description
  end
end
