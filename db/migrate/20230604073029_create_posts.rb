class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :location_name, null: false
      t.string :address, null: false
      t.decimal :latitude,  precision: 11, scale: 8, null: false #緯度
      t.decimal :longitude, precision: 11, scale: 8, null: false #経度
      t.string :memo, null: false
      t.integer :prefecture, null: false
      t.integer :is_released, null: false, default: 0 #公開・非公開ステータス
      t.integer :location_genre, null: false

      t.timestamps
    end
  end
end
