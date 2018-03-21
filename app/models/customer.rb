class Customer < ApplicationRecord
  belongs_to :province

  mount_uploader :image, ImageUploader

  validates :name, presence: true
end
