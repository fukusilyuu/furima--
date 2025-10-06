class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :replies
  validates :text, presence: true
end
