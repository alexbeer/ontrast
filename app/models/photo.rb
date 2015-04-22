class Photo < ActiveRecord::Base
  belongs_to :contest

  validates :email, presence: true, email: true
  validates :name, presence: true
  validates :caption, presence: true
  validates :image_large_url, presence: true
  validates :image_medium_url, presence: true
  validates :image_thumb_url, presence: true
end