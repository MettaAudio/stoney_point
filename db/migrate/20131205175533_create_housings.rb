class CreateHousings < ActiveRecord::Migration
  def change
    create_table :housings do |t|
      t.date :available
      t.integer :number_of_bedrooms
      t.integer :number_of_bathrooms
      t.belongs_to :volunteer
      t.timestamps
    end
  end
end
