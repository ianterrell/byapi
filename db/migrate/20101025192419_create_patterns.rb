class CreatePatterns < ActiveRecord::Migration
  def self.up
    create_table :patterns do |t|
      t.integer :site_id
      t.text :properties
      t.string :name
      t.string :view

      t.timestamps
    end
    add_index :patterns, :site_id
  end

  def self.down
    remove_index :patterns, :site_id
    drop_table :patterns
  end
end
