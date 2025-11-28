class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
  belongs_to_active_hash :quality
  belongs_to_active_hash :payment
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days
  validates :name, :image, :price, :explanation, :genre_id, :quality_id, :payment_id, :prefecture_id, :days_id,
            presence: true
  validates :price, numericality: { less_than: 9_999_999, greater_than: 300 }

  with_options numericality: { other_than: 0 } do
    validates :genre_id
    validates :quality_id
    validates :payment_id
    validates :prefecture_id
    validates :days_id
  end

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :replies
  has_one :order
  has_many :exchanges
  has_many :likes, dependent: :destroy

  has_one_attached :image, dependent: :destroy

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # Ransack検索で許可するカラム一覧
  def self.ransackable_attributes(auth_object = nil)
    # %w[id name price explanation created_at updated_at genre_id user_id]
    %w[item name price explanation genre_id quality_id payment_id days_id prefecture_id created_at updated_at]
  end

  # 関連モデルも検索対象にする場合（例: category.name_cont など）
  def self.ransackable_associations(auth_object = nil)
    %w[genre quality payment prefecture days user]
  end
end
