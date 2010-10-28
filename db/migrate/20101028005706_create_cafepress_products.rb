class CreateCafepressProducts < ActiveRecord::Migration
  def self.up
    create_table :cafepress_products do |t|
      t.string :cafepress_id
      t.integer :product_id
      t.integer :design_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cafepress_products
  end
end
