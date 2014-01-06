class AddNumberOfShirtsToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :number_of_shirts, :integer, default: 1
  end
end
