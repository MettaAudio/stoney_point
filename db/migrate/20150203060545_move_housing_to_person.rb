class MoveHousingToPerson < ActiveRecord::Migration
  def up
    add_column :housings, :person_id, :integer
    add_index  :housings, :person_id

    Housing.all.each do |housing|
      housing.person_id = housing.volunteer.person_id
      housing.save!
    end

    remove_column :housings, :volunteer_id, :integer
  end

  def down
    add_column :housings, :volunteer_id, :integer

    Housing.all.each do |housing|
      housing.volunteer_id = housing.person.volunteer.id
      housing.save!
    end

    remove_column :housings, :person_id, :integer
  end
end
