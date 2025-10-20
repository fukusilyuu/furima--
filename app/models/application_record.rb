class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
