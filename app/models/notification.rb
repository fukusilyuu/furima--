class Notification < ApplicationRecord
  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
  belongs_to :product, optional: true
  belongs_to :comment, optional: true

  validates :action, presence: true
end
