class AddStreamLinkVideoLinkToSong < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :stream_link, :string
    add_column :songs, :video_link, :string
  end
end
