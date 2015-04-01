class AddEmailToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :email, :string
  end
end
