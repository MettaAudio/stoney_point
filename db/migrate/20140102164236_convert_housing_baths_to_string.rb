class ConvertHousingBathsToString < ActiveRecord::Migration
  def self.up
    change_column :housings, :number_of_bathrooms, :string
  end

  def self.down
    change_column :housings, :number_of_bathrooms, :integer
  end
end
