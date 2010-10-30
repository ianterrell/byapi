class AddCachedSlugToDesign < ActiveRecord::Migration
  def self.up
    add_column :designs, :cached_slug, :string
  end

  def self.down
    remove_column :designs, :cached_slug
  end
end
