class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :comment
  validates :context, presence: true
end
