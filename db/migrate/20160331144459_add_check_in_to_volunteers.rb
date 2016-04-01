class AddCheckInToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :thursday_checkin, :boolean
    add_column :volunteers, :friday_checkin, :boolean
    add_column :volunteers, :saturday_checkin, :boolean
    add_column :volunteers, :sunday_checkin, :boolean
  end
end
