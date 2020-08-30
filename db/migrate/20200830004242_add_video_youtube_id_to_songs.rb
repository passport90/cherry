class AddVideoYoutubeIdToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :video_youtube_id, :string
  end
end
