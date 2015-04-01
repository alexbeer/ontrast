class Photo < ActiveRecord::Base
  belongs_to :contest

  validates :email, presence: true, email: true
  validates :name, presence: true
  validates :image, presence: true
  validates :caption, presence: true

  mount_uploader :image, PhotoUploader
end