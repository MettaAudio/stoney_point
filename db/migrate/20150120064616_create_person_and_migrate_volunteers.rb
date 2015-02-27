class CreatePersonAndMigrateVolunteers < ActiveRecord::Migration
  def up
    # Add table
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone
      t.integer :organization_id
      t.boolean :is_active
    end

    # add link
    add_index       :people, :organization_id

    add_column      :volunteers, :person_id, :integer
    add_index       :volunteers, :person_id

    # migrate data
    Volunteer.all.each do |volunteer|
      person = Person.new(
        :first_name      => volunteer.first_name,
        :last_name       => volunteer.last_name,
        :street          => volunteer.street,
        :city            => volunteer.city,
        :state           => volunteer.state,
        :zip             => volunteer.zip,
        :phone           => volunteer.primary_phone,
        :email           => volunteer.email,
        :organization_id => volunteer.organization_id,
        :is_active       => volunteer.is_active
        )

      person.save!
      volunteer.person = person
      volunteer.save!
    end

    # drop columns
    remove_column :volunteers, :first_name, :string
    remove_column :volunteers, :last_name, :string
    remove_column :volunteers, :street, :string
    remove_column :volunteers, :city, :string
    remove_column :volunteers, :state, :string
    remove_column :volunteers, :zip, :integer
    remove_column :volunteers, :primary_phone, :string
    remove_column :volunteers, :secondary_phone, :string
    remove_column :volunteers, :email, :string
    remove_column :volunteers, :organization_id, :boolean
    remove_column :volunteers, :is_active, :boolean
  end

  def down
    # add columns
    add_column :volunteers, :first_name, :string
    add_column :volunteers, :last_name, :string
    add_column :volunteers, :street, :string
    add_column :volunteers, :city, :string
    add_column :volunteers, :state, :string
    add_column :volunteers, :zip, :integer
    add_column :volunteers, :primary_phone, :string
    add_column :volunteers, :secondary_phone, :string
    add_column :volunteers, :email, :string
    add_column :volunteers, :organization_id, :boolean
    add_column :volunteers, :is_active, :boolean

    # migrate data
    Person.all.each do |person|
      volunteer = person.volunteer
      volunteer.update_attributes(
        :first_name      => person.first_name,
        :last_name       => person.last_name,
        :street          => person.street,
        :city            => person.city,
        :state           => person.state,
        :zip             => person.zip,
        :primary_phone   => person.phone,
        :email           => person.email,
        :organization_id => person.organization_id,
        :is_active       => person.is_active
      )
    end

    # drop link
      remove_column      :volunteers, :person_id, :integer

    # drop table
    drop_table :people
  end
end
