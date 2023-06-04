class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :account_id, length: { in: 6..12 }, format: { with: /\A[0-9a-zA-Z]*\z/ }
  validates :password, length: { in: 6..12 },  format: { with: /\A[0-9a-zA-Z]*\z/ }

end
