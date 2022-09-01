class Hotel < ApplicationRecord
  belongs_to :user
  has_many :reservations
  validates :user_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, numericality: {
      only_integer: true, 
      greater_than_or_equal_to: 0, 
      less_than_or_equal_to: 1000000
  }
  validates :introduction, presence: true
  mount_uploader :image, ImageUploader
  
end
