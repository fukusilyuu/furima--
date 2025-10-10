class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :comment
  has_many :likes, dependent: :destroy
  validates :context, presence: true
end
