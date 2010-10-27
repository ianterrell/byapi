class AddCafepressFieldsToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :cafepress_id, :string
    add_column :designs, :cafepress_dark_id, :string
    add_column :designs, :cafepress_media_url, :string
    add_column :designs, :cafepress_dark_media_url, :string
  end

  def self.down
    remove_column :designs, :cafepress_dark_media_url
    remove_column :designs, :cafepress_media_url
    remove_column :designs, :cafepress_dark_id
    remove_column :designs, :cafepress_id
  end
end
