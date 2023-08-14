# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!(
  [
    {email: 'takeshi123@example.com', name: 'たけし', password: 'password1', account_id: 'takeshi123', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: 'tanaka123@example.com', name: 'Tanaka', password: 'password2', account_id: 'tanaka123', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
    {email: 'yukiko123@example.com', name: 'ゆきこ', password: 'password3', account_id: 'yuki123', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")}
  ]
)

Post.create!(
  [
    {location_name: '久楽', address: '日本、〒682-0861 鳥取県倉吉市新町１丁目２４２４−２', latitude: 35.432249, longitude: 133.823942, prefecture: "tottori", location_genre: "food", is_released: "released", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), memo: '大人気の古民家カフェです。', user_id: users[0].id },
    {location_name: 'CafeSeedOfLife',address: '日本、〒700-0836 岡山県岡山市北区中央町３−１９ ニシキヤビル', latitude: 34.6572521, longitude: 133.9259799, prefecture: "okayama", location_genre: "food", is_released: "released", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), memo: 'ヴィーガン料理のお店です。', user_id: users[1].id },
    {location_name: '金刀比羅宮', address: '日本、〒766-8501 香川県仲多度郡琴平町８９２−１', latitude: 34.1839981, longitude: 133.8095371, prefecture: "kagawa", location_genre: "location", is_released: "released", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), memo: '香川にある有名な場所！', user_id: users[2].id }
  ]
)

Admin.create!(
  email: 'admin123@example.com',
  password: 'adminpassword'
)