class AddDarkToPatterns < ActiveRecord::Migration
  def self.up
    add_column :patterns, :has_dark, :boolean, :default => true
  end

  def self.down
    remove_column :patterns, :has_dark
  end
end
