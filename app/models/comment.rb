class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :replies, dependent: :destroy
  validates :text, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
