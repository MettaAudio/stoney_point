class AddJrClinicTimeToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :jr_clinic_day_time, :string
  end
end
