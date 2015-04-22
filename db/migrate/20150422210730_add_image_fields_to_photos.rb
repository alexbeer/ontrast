class AddImageFieldsToPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :image
    add_column :photos, :image_large_url, :string
    add_column :photos, :image_medium_url, :string
    add_column :photos, :image_thumb_url, :string
  end
end
