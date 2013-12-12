class AddPaidToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :paid, :boolean
    add_column :volunteers, :physical_activity, :boolean
    add_column :volunteers, :shirt_size, :string
  end
end
