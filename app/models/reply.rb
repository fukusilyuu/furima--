class Reply < ApplicationRecord
  belongs_to :comment
  validates :context, presence: :true
end
