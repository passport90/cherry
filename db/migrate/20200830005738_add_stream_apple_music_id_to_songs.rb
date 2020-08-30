class AddStreamAppleMusicIdToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :stream_apple_music_id, :string
  end
end
