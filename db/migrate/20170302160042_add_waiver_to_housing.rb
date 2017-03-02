class AddWaiverToHousing < ActiveRecord::Migration
  def change
    add_column :housings, :waiver, :boolean
  end
end
