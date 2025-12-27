class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :replies, dependent: :destroy
  validates :text, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  after_create_commit :create_comment_notification

  private

  def create_comment_notification
    return if user_id == item.user_id # 自分の投稿には通知しない

    item.user.create_comment_notification!(user, self)
  end
end
