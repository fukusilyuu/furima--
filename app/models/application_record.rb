class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def followed_by?(user)
    follower = passive_relationships.find_by(following_id: user.id)
    follower.present?
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
