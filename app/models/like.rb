class Like < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :comment
  belongs_to :reply

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
