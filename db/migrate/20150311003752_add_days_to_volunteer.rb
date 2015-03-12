class AddDaysToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :wednesday, :string
    add_column :volunteers, :thursday, :string
    add_column :volunteers, :friday, :string
    add_column :volunteers, :saturday, :string
    add_column :volunteers, :sunday, :string

    remove_column :volunteers, :availability, :string
    remove_column :volunteers, :sessions, :string
  end
end
