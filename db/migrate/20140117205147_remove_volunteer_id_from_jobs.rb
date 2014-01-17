class RemoveVolunteerIdFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :volunteer_id, :integer
    remove_column :jobs, :committee_id, :integer
    create_table :jobs_volunteers do |t|
      t.belongs_to :volunteer
      t.belongs_to :job
    end
  end
end
