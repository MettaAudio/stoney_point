class AddWaiverToGolfer < ActiveRecord::Migration
  def change
    add_column :golfers, :waiver, :boolean
  end
end
