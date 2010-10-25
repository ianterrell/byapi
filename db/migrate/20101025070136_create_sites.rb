class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :domain, :title
      t.timestamps
    end
    add_index :sites, :domain
  end

  def self.down
    remove_index :sites, :domain
    drop_table :sites
  end
end
