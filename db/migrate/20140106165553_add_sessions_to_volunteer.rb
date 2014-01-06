class AddSessionsToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :sessions, :string
  end
end
