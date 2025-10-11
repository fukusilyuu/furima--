class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :replies, dependent: :destroy
  validates :text, presence: true
end
