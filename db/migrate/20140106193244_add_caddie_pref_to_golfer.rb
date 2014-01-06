class AddCaddiePrefToGolfer < ActiveRecord::Migration
  def change
    add_column :golfers, :caddie_preferences, :text
  end
end
