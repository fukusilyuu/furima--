class Comment < ApplicationRecord
  has_many :replies
  validates :text, presence: :true
end
