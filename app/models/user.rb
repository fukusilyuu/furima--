class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :email
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
    validates :firstname_kanji, :lastname_kanji, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
    validates :firstname_katakana, :lastname_katakana, format: { with: /\A[ァ-ヶー－]+\z/ }
  end

  has_many :active_relationships, class_name: 'Relationship', foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    follower = passive_relationships.find_by(following_id: user.id)
    follower.present?
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  has_many :items
  has_many :replies
  has_many :comments
  has_many :likes
  has_many :orders
end
