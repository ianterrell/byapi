class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.string :name

      t.timestamps
    end
    add_column :sites, :current_store_id, :integer
    add_column :designs, :store_id, :integer
  end

  def self.down
    remove_column :designs, :store_id
    remove_column :sites, :current_store_id
    drop_table :stores
  end
end
