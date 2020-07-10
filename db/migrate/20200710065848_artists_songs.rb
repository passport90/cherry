class ArtistsSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :artists_songs do |t|
      t.belongs_to :artist
      t.belongs_to :song

      t.timestamps
    end
  end
end
