class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :title
      t.string :header_image

      t.text :prize
      t.text :description
      t.text :rules
      t.string :name
      t.string :email
      t.string :company

      t.datetime :start_at
      t.datetime :end_at

      t.string :status, null: false, default: 'pending'

      t.timestamps
    end
  end
end
