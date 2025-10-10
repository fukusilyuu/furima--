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
  has_many :items
  has_many :replies
  has_many :comments
  has_many :orders
end
