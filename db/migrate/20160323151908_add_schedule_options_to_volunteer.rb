class AddScheduleOptionsToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :thursday_time, :datetime
    add_column :volunteers, :thursday_hole, :integer
    add_column :volunteers, :friday_time, :datetime
    add_column :volunteers, :friday_hole, :integer
    add_column :volunteers, :saturday_time, :datetime
    add_column :volunteers, :saturday_hole, :integer
    add_column :volunteers, :sunday_time, :datetime
    add_column :volunteers, :sunday_hole, :integer
  end
end
