class Exchange < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipping

  belongs_to :user
  belongs_to :item
  belongs_to :order

  validates :message, presence: true
  validates :shipping_id, presence: false
end
