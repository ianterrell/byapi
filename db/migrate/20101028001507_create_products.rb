class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :section
      t.string :cafepress_id
      t.string :media_regions
      t.string :default_region
      t.string :default_alignment

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
