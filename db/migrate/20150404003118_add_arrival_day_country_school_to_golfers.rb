class AddArrivalDayCountrySchoolToGolfers < ActiveRecord::Migration
  def change
    add_column :golfers, :arrival_day, :string
    add_column :golfers, :country, :string
    add_column :golfers, :school, :string
  end
end
