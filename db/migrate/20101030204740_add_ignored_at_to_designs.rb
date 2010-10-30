class AddIgnoredAtToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :ignored_at, :datetime
  end

  def self.down
    remove_column :designs, :ignored_at
  end
end
