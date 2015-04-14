class AddSocialFieldsToContests < ActiveRecord::Migration
  def change
    add_column :contests, :facebook_handle, :string
    add_column :contests, :twitter_handle, :string
    add_column :contests, :instagram_handle, :string
    add_column :contests, :website_url, :string
  end
end
