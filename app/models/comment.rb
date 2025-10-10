class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :replies, dependent: :destroy
  has_many :likes
  validates :text, presence: true
end
