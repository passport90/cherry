class AddIsAcclaimedToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :is_acclaimed, :boolean, null: false, default: false
  end
end
