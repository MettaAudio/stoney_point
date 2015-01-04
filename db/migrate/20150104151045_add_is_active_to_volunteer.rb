class AddIsActiveToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :is_active, :boolean
  end
end
