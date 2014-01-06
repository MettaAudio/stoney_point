class AddAvailabilityToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :availability, :string
  end
end
