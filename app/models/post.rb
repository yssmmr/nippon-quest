class Post < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_one_attached :image

  validates :user_id, presence: true
  validates :location_name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :memo, presence: true
  validates :prefecture, presence: true
  validates :location_genre, presence: true
  validates :released_flag, presence: true

  enum prefecture: {
                    hokkaido: 0,
                    aomori: 1,
                    iwate: 2,
                    miyagi: 3,
                    akita: 4,
                    yamagata: 5,
                    fukushima:6,
                    ibaraki: 7,
                    tochigi: 8,
                    gunma: 9,
                    saitama: 10,
                    chiba: 11,
                    tokyo: 12,
                    kanagawa: 13,
                    nigata: 14,
                    toyama: 15,
                    ishikawa: 16,
                    fukui: 17,
                    yamanashi: 18,
                    nagano: 19,
                    gifu: 20,
                    shizuoka: 21,
                    aichi: 22,
                    mie: 23,
                    shiga: 24,
                    kyoto: 25,
                    osaka: 26,
                    hyogo: 27,
                    nara: 28,
                    wakayama: 29,
                    tottori: 30,
                    shimane: 31,
                    okayama: 32,
                    hiroshima: 33,
                    yamaguchi: 34,
                    tokushima: 35,
                    kagawa: 36,
                    ehime: 37,
                    kochi: 38,
                    fukuoka: 39,
                    saga: 40,
                    nagasaki: 41,
                    kumamoto: 42,
                    oita: 43,
                    miyazaki: 44,
                    kagoshima: 45,
                    okinawa: 46,
  }

  enum location_genre: { food: 0, location: 1 }

  enum released_flag: { released: 0, not_released: 1}


  def self.ransackable_scopes(auth_object = nil)
    ["released"]
  end


  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "id", "latitude", "location_genre", "location_name", "longitude", "memo", "prefecture", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["favorites", "image_attachment", "image_blob", "notifications", "user"]
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def create_notification_favorite!(current_user)

    #すでにいいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favolite'])

    #いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: "favorite"
      )

    #自分の投稿に対するいいねの場合は通知済みにする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def get_image
    if image.attached?
      image
    else
       'no-image.jpg'
    end
  end

  def showable?(viewer)
    return true if released?
    not_released? && viewer.present? && user == viewer
  end
end
