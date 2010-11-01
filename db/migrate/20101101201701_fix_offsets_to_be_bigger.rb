class FixOffsetsToBeBigger < ActiveRecord::Migration
  def self.up
    change_column :designs, :offsets, :text
  end

  def self.down
    change_column :designs, :offsets, :string
  end
end
