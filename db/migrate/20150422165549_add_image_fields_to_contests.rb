class AddImageFieldsToContests < ActiveRecord::Migration
  def change
    remove_column :contests, :header_image
    add_column :contests, :image_large_url, :string
    add_column :contests, :image_medium_url, :string
    add_column :contests, :image_thumb_url, :string
  end
end
