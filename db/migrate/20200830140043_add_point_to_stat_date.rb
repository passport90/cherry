class AddPointToStatDate < ActiveRecord::Migration[6.0]
  def change
    add_column :stat_dates, :point, :integer
  end
end
