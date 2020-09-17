class Deck < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 15 }
  validates :comment, length: { maximum: 255 }
  validates :number_of_use, numericality: { only_integer: true }
  validates :number_of_wins, numericality: { only_integer: true }
  mount_uploader :imagefile_name, ImageUploader
  
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
end