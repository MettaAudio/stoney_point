class AddWavierToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :waiver, :boolean
  end
end
