class RemoveStreamLinkVideoLinkFromSongs < ActiveRecord::Migration[6.0]
  def change
    remove_column :songs, :video_link, :string
    remove_column :songs, :stream_link, :string
  end
end
