class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def followed_by?(user)
    follower = passive_relationships.find_by(following_id: user.id)
    follower.present?
  end
end
