class ChangePatternsOffsetsToText < ActiveRecord::Migration
  def self.up
    change_column :patterns, :offsets, :text
  end

  def self.down
    change_column :patterns, :offsets, :string
  end
end
