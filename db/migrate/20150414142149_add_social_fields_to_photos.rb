class AddSocialFieldsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :facebook_handle, :string
    add_column :photos, :twitter_handle, :string
    add_column :photos, :instagram_handle, :string
    add_column :photos, :website_url, :string
  end
end
