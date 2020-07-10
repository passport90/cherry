class ArtistsSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :artists_songs do |t|
      t.belongs_to :artist, null: false
      t.belongs_to :song, null: false

      t.timestamps
    end

    add_index :artists_songs, [:artist_id, :song_id], unique: true
  end
end
