class RemovePaddingFields < ActiveRecord::Migration
  def self.up
    remove_column :designs, :cafepress_id_padded_x
    remove_column :designs, :cafepress_id_padded_y
    remove_column :designs, :cafepress_id_padded_y_big
    remove_column :products, :padding
  end

  def self.down
    add_column :products, :padding, :string
    add_column :designs, :cafepress_id_padded_y_big, :string
    add_column :designs, :cafepress_id_padded_y, :string
    add_column :designs, :cafepress_id_padded_x, :string
  end
end
