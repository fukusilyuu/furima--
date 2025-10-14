class Relationship < ApplicationRecord
  belongs_to :following, class_name: 'User'
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'Item'
  belongs_to :follower, class_name: 'Item'
end
