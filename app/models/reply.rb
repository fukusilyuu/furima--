class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :comment
  has_many :likes, as: :likeable, dependent: :destroy

  validates :context, presence: true
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
