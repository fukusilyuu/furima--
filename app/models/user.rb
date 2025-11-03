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

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)
    following << other_user unless self == other_user
  end

  # フォロー解除
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id)&.destroy
  end

  # フォローしているか確認
  def following?(other_user)
    followings.include?(other_user)
  end

  # フォローされているか確認
  def followed_by?(user)
    return false if user.nil? # ← これを追加

    passive_relationships.exists?(follower_id: user.id)
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  has_many :items
  has_many :replies
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :orders
  has_many :exchanges
  has_one_attached :image, dependent: :destroy
end
