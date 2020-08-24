class CreateStatDates < ActiveRecord::Migration[6.0]
  def change
    create_table :stat_dates do |t|
      t.belongs_to :song, null: false, index: {unique: true}
      t.integer :median_year
      t.integer :median_week

      t.timestamps
    end

    add_index :stat_dates, [:median_year, :median_week]
  end
end
