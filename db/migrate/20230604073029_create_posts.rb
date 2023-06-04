class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :image_id
      t.integer :location_name, null: false
      t.integer :address, null: false
      t.decimal :latitude, null: false #緯度
      t.decimal :longitude, null: false #経度
      t.integer :memo, null: false
      t.integer :prefecture, null: false
      t.integer :location_genre, null: false

      t.timestamps
    end
  end
end
