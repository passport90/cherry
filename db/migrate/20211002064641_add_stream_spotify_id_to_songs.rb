class AddStreamSpotifyIdToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :stream_spotify_id, :string
  end
end
