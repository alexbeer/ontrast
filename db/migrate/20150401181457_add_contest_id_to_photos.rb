class AddContestIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :contest_id, :integer
  end
end
