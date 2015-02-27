class MigrateGolferDataToPerson < ActiveRecord::Migration
  def up
    # add link
    add_column      :golfers, :person_id, :integer
    add_index       :golfers, :person_id

    # Move data
    Golfer.all.each do |golfer|
      person = Person.new(
        :first_name      => golfer.first_name,
        :last_name       => golfer.last_name,
        :email           => golfer.email,
        :is_active       => golfer.is_active
      )

      person.save!
      golfer.person = person
      golfer.save!
    end

    # drop columns
    remove_column :golfers, :first_name,      :string
    remove_column :golfers, :last_name,       :string
    remove_column :golfers, :email,           :string
    remove_column :golfers, :is_active,       :boolean
  end

  def down
    # add columns
    add_column :golfers, :first_name,      :string
    add_column :golfers, :last_name,       :string
    add_column :golfers, :email,           :string
    add_column :golfers, :is_active,       :boolean

    # migrate data
    Golfer.all.each do |golfer|
      golfer.update_attributes(
        :first_name      => golfer.person.first_name,
        :last_name       => golfer.person.last_name,
        :email           => golfer.person.email,
        :is_active       => golfer.person.is_active
      )

      golfer.person.destroy
    end

    # drop link
    remove_index       :golfers, :person_id
    remove_column      :golfers, :person_id, :integer
  end
end
