class AddIsLikedRatingToSong < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :is_liked, :boolean, null: false, default: false
    add_column :songs, :rating, :numeric, precision: 3, scale: 2
  end
end
