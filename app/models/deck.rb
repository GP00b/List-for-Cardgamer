class Deck < ApplicationRecord
  belongs_to :user
  
  validates :name, {presence: true}
  validates :comment, {presence: true}
  mount_uploader :imagefile_name, ImageUploader
  
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
end
