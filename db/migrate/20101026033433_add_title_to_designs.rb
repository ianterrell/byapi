class AddTitleToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :title, :string
  end

  def self.down
    remove_column :designs, :title
  end
end
