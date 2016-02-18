class AddFieldsToHousings < ActiveRecord::Migration
  def change
    add_column :housings, :max_guests, :integer
    add_column :housings, :specific_golfers, :boolean
  end
end
