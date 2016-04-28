class AddDailyJobToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :thursday_job_id, :integer
    add_column :volunteers, :friday_job_id, :integer
    add_column :volunteers, :saturday_job_id, :integer
    add_column :volunteers, :sunday_job_id, :integer
  end
end
