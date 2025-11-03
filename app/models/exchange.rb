class Exchange < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :order

  validates :message, presence: true
end
