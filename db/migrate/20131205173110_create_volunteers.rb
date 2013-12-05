class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :primary_phone
      t.integer :secondary_phone
      t.string :email

      t.timestamps
    end
  end
end
