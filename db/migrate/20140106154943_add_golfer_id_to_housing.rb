class AddGolferIdToHousing < ActiveRecord::Migration
  def change
    add_column :housings, :golfer_id, :integer
  end
end
