# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

takeshi = User.find_or_create_by!(email: "takeshi123@example.com") do |user|
   user.name = "たけし"
   user.password = "password1"
   user.account_id = "takeshi123"
   user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename: "sample-user1.jpg")
end

tanaka = User.find_or_create_by!(email: "tanaka123@example.com") do |user|
   user.name = "Tanaka"
   user.password = "password2"
   user.account_id = "tanaka123"
   user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename: "sample-user2.jpg")
end

yukiko = User.find_or_create_by!(email: "yukiko123@example.com") do |user|
   user.name = "ゆきこ"
   user.password = "password3"
   user.account_id = "yuki123"
   user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename: "sample-user3.jpg")
end

takeshi.posts.find_or_create_by!(location_name: "久楽") do |post|
  post.address = "日本、〒682-0861 鳥取県倉吉市新町１丁目２４２４−２"
  post.latitude = 35.432249
  post.longitude = 133.823942
  post.prefecture = "tottori"
  post.location_genre = "food"
  post.released_flag = "released"
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename: "sample-post1.jpg")
  post.memo = "大人気の古民家カフェです。"
end

tanaka.posts.find_or_create_by!(location_name: "CafeSeedOfLife") do |post|
  post.address = "日本、〒700-0836 岡山県岡山市北区中央町３−１９ ニシキヤビル"
  post.latitude = 34.6572521
  post.longitude = 133.9259799
  post.prefecture = "okayama"
  post.location_genre = "food"
  post.released_flag = "released"
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename: "sample-post2.jpg")
  post.memo = "ヴィーガン料理のお店です。"
end

yukiko.posts.find_or_create_by!(location_name: "金刀比羅宮") do |post|
  post.address = "日本、〒766-8501 香川県仲多度郡琴平町８９２−１"
  post.latitude = 34.1839981
  post.longitude = 133.8095371
  post.prefecture = "kagawa"
  post.location_genre = "location"
  post.released_flag = "released"
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename: "sample-post3.jpg")
  post.memo = "香川にある有名な場所！"
end

Admin.find_or_create_by!(email: "admin123@example.com") do |admin|
  admin.password = "adminpassword"
end

p "データの作成に成功しました！"
