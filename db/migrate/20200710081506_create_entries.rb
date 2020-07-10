class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.integer :year, null: false
      t.integer :week, null: false
      t.integer :position, null: false
      t.belongs_to :song, null: false

      t.timestamps
    end


    add_index :entries, [:year, :week, :position], unique: true
    add_index :entries, [:year, :week, :song_id], unique: true
  end
end
