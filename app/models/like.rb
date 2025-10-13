class Like < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def liked_by?(item)
    likes.where(item_id: item.id).exists?
  end
end
