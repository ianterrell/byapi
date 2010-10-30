class RemoveSubsectionsFromDesign < ActiveRecord::Migration
  def self.up
    remove_column :designs, :cafepress_apparel_section_id
    remove_column :designs, :cafepress_other_section_id
    rename_column :designs, :cafepress_top_section_id, :cafepress_section_id
  end

  def self.down
    rename_column :designs, :cafepress_section_id, :cafepress_top_section_id
    add_column :designs, :cafepress_other_section_id, :string
    add_column :designs, :cafepress_apparel_section_id, :string
  end
end
