class AddOffsetsToDesigns < ActiveRecord::Migration
  def self.up
    add_column :patterns, :offsets, :string
    add_column :designs, :offsets, :string, :length => 512
  end

  def self.down
    remove_column :designs, :offsets
    remove_column :patterns, :offsets
  end
end
