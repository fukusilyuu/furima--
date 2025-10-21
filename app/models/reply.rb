class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :comment
  has_many :likes
  validates :context, presence: true
end
