class AddPaddedCafepressToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :cafepress_id_padded_x, :string
    add_column :designs, :cafepress_id_padded_y, :string
    add_column :designs, :cafepress_id_padded_y_big, :string
  end

  def self.down
    remove_column :designs, :cafepress_id_padded_y_big
    remove_column :designs, :cafepress_id_padded_y
    remove_column :designs, :cafepress_id_padded_x
  end
end
