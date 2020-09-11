class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :deck
  
  validates_uniqueness_of :deck_id, scope: :user_id
end
