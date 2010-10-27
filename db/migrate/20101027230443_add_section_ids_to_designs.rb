class AddSectionIdsToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :cafepress_top_section_id, :string
    add_column :designs, :cafepress_apparel_section_id, :string
    add_column :designs, :cafepress_other_section_id, :string
  end

  def self.down
    remove_column :designs, :cafepress_other_section_id
    remove_column :designs, :cafepress_apparel_section_id
    remove_column :designs, :cafepress_top_section_id
  end
end
