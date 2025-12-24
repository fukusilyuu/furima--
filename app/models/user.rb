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

  has_many :active_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :followed_id

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :active_notifications,
           class_name: 'Notification',
           foreign_key: 'visitor_id',
           dependent: :destroy

  has_many :passive_notifications,
           class_name: 'Notification',
           foreign_key: 'visited_id',
           dependent: :destroy

  # フォロー通知
  def create_follow_notification!(user)
    active_notifications.create!(
      visited_id: user.id,
      action: 'follow'
    )
  end

  # 相互フォロー通知
  def create_mutual_notification!(user)
    active_notifications.create!(
      visitor: self,
      visited: user,
      notifiable: self,
      action: 'mutual'
    )
  end

  def create_like_notification!(current_user, item)
    active_notifications.create!(
      visited_id: item.user_id,
      notifiable: item,
      action: 'like'
    )
  end

  def create_comment_notification!(current_user, comment)
    active_notifications.create!(
      visited_id: comment.item.user,
      notifiable: comment,
      action: 'comment'
    )
  end

  def create_follow_notification!(current_user)
    notifications.create!(
      visitor: current_user,
      visited: self,
      action: 'follow'
    )
  end

  def follow(user)
    following << user unless self == user
  end

  def unfollow(user)
    following.destroy(user)
  end

  def following?(user)
    following.include?(user)
  end

  def followed_by?(user)
    followers.include?(user)
  end

  def following_count
    following.count
  end

  def mutual_follow?(other_user)
    return false if other_user.nil?

    following?(other_user) && other_user.following?(self)
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
  has_many :notifications, as: :notifiable, dependent: :destroy

  has_one_attached :image, dependent: :destroy
end
