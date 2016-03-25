class ChangeTimeTypeOnVolunteer < ActiveRecord::Migration
  def change
    change_column :volunteers, :thursday_time, :string
    change_column :volunteers, :friday_time, :string
    change_column :volunteers, :saturday_time, :string
    change_column :volunteers, :sunday_time, :string
  end
end
