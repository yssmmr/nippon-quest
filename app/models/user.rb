class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :posts, dependent: :destroy

  #フォローをした、フォローをされた関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  #フォロー・フォロワー一覧の画面で使用する関係
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :favorites, dependent: :destroy
  # has_many :notifications, dependent: :destroy


  validates :account_id, length: { in: 6..12 }, format: { with: /\A[0-9a-zA-Z]*\z/ }
  validates :password, length: { in: 6..12 },  format: { with: /\A[0-9a-zA-Z]*\z/ }, on: :create
  validates :email, presence: true
  validates :name, presence: true
  validates :account_id, presence: true

  def self.guest #ゲストユーザー作成機能
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.account_id = "guest123"
    end
  end

  #フォローした時の処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  #フォローを外した時の処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  #フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["account_id", "created_at", "email", "encrypted_password", "id", "introduction", "is_deleted", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

  def get_profile_image

    if profile_image.attached?
      profile_image
    else
       'no-image.jpg'
    end
  end

end
