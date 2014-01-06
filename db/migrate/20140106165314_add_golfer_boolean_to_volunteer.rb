class AddGolferBooleanToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :golfer, :boolean
  end
end
