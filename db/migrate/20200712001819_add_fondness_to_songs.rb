class AddFondnessToSongs < ActiveRecord::Migration[6.0]
  def change
    remove_column :songs, :is_liked, :boolean, null: false, default: false
    add_column :songs, :fondness, :integer, null: false, default: 0
  end
end
