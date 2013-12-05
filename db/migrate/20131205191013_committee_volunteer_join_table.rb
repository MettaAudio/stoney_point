class CommitteeVolunteerJoinTable < ActiveRecord::Migration
  def change
    create_table :committees_volunteers do |t|
      t.belongs_to :volunteer
      t.belongs_to :committee
    end
  end
end
