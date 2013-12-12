class AddBooleansToHousing < ActiveRecord::Migration
  def change
    add_column :housings, :pets, :boolean
    add_column :housings, :smoking, :boolean
  end
end
