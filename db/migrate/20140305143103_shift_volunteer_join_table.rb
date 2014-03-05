class ShiftVolunteerJoinTable < ActiveRecord::Migration
  def change
    create_table :shifts_volunteers do |t|
      t.belongs_to :volunteer
      t.belongs_to :shift
    end
  end
end
