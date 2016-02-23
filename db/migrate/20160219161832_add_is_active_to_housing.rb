class AddIsActiveToHousing < ActiveRecord::Migration
  def change
    add_column :housings, :is_active, :boolean
  end
end
