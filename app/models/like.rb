class Like < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :comment
  belongs_to :reply

  def liked_by?(item)
    likes.where(item_id: item.id).exists?
  end

  def liked_by?(comment)
    likes.where(comment_id: comment.id).exists?
  end

  def liked_by?(reply)
    likes.where(reply_id: reply.id).exists?
  end
end
