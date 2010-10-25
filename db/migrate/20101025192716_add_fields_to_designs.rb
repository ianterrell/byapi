class AddFieldsToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :sales_count, :integer, :default => 0
    add_column :designs, :approved_at, :datetime
  end

  def self.down
    remove_column :designs, :published
    remove_column :designs, :sales_count
  end
end
