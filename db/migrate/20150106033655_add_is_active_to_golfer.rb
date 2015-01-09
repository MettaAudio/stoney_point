class AddIsActiveToGolfer < ActiveRecord::Migration
  def change
    add_column :golfers, :is_active, :boolean
  end
end
