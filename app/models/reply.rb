class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :comment
  has_many :likes, as: :likeable, dependent: :destroy

  validates :context, presence: true
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  after_create_commit :create_reply_notification

  private

  def create_reply_notification
    return if user_id == item.user_id # 自分の投稿には通知しない

    item.user.create_reply_notification!(user, self)
  end
end
