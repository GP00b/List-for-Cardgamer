class User < ApplicationRecord
  has_secure_password
  
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  mount_uploader :imagefile_name, ImageUploader
  
  def decks
    return Deck.where(user_id: self.id)
  end
  
  has_many :decks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_decks, through: :favorites, source: :deck
  
  def favorited?(deck)
    self.favorites.exists?(deck_id: deck.id)
  end

end