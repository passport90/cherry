class ChangeIndexesOfEntry < ActiveRecord::Migration[6.0]
  def change
    remove_index :entries, name: 'index_entries_on_year_and_week_and_song_id'
    add_index :entries, :year
    add_index :entries, [:year, :week]
  end
end
