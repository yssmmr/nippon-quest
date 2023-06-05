class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy


  validates :account_id, length: { in: 6..12 }, format: { with: /\A[0-9a-zA-Z]*\z/ }
  validates :password, length: { in: 6..12 },  format: { with: /\A[0-9a-zA-Z]*\z/ }


  def self.guest #ゲストユーザー作成機能
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.account_id = "guest123"
    end
  end

end
