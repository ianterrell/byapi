class CreateDesigns < ActiveRecord::Migration
  def self.up
    create_table :designs do |t|
      t.integer :site_id
      t.integer :pattern_id
      t.text :properties

      t.timestamps
    end
    add_index :designs, :site_id
  end

  def self.down
    remove_index :designs, :site_id
    drop_table :designs
  end
end
