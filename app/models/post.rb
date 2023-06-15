class Post < ApplicationRecord

  belongs_to :user
  # has_many :notifications, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  validates :user_id, presence: true
  validates :location_name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :memo, presence: true
  validates :prefecture, presence: true
  validates :location_genre, presence: true


  enum prefecture: { hokkaido: 0, aomori: 1, iwate: 2, akita: 3, miyagi: 4,
                     yamagata: 5, fukushima: 6, nigata: 7, tochigi: 8,
                     ibaraki: 9, gunma: 10, chiba: 11, tokyo: 12, saitama: 13,
                     kanagawa: 14, yamanashi: 15, nagano: 16, toyama: 17,
                     shizuoka: 18, aichi: 19, gifu: 20, ishikawa: 21, fukui: 22,
                     mie: 23, shiga: 24, kyoto: 25, osaka: 26, hyogo: 27,
                     nara: 28, wakayama: 29, tottori: 30, shimane: 31, okayama: 32,
                     hiroshima: 33, yamaguchi: 34, tokushima: 35, kagawa: 36,
                     ehime: 37, kochi: 38, fukuoka: 39, saga: 40, nagasaki: 41,
                     kumamoto: 42, oita: 43, miyazaki: 44, kagoshima:45, okinawa:46
                    }

  enum location_genre: { restarant: 0, location: 1 }

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "id", "latitude", "location_genre", "location_name", "longitude", "memo", "prefecture", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["favorites", "image_attachment", "image_blob", "notifications", "user"]
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def get_image
    if image.attached?
      image
    else
       'no-image.jpg'
    end
  end
end
