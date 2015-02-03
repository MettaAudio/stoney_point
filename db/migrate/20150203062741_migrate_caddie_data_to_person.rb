class MigrateCaddieDataToPerson < ActiveRecord::Migration
  def up
    # add link
    add_column      :caddies, :person_id, :integer
    add_index       :caddies, :person_id

    # Move data
    Caddie.all.each do |caddie|
      person = Person.new(
        :first_name      => caddie.first_name,
        :last_name       => caddie.last_name,
        :phone           => caddie.phone,
        :email           => caddie.email,
        :organization_id => caddie.organization_id,
        :is_active       => caddie.is_active
        )

      person.save!
      caddie.person = person
      caddie.save!
    end

    # drop columns
    remove_column :caddies, :first_name,      :string
    remove_column :caddies, :last_name,       :string
    remove_column :caddies, :phone,           :integer
    remove_column :caddies, :email,           :string
    remove_column :caddies, :organization_id, :integer
    remove_column :caddies, :is_active,       :boolean
  end

  def down
    # add columns
    add_column :caddies, :first_name,      :string
    add_column :caddies, :last_name,       :string
    add_column :caddies, :phone,           :integer
    add_column :caddies, :email,           :string
    add_column :caddies, :organization_id, :integer
    add_column :caddies, :is_active,       :boolean

    # migrate data
    Caddie.all.each do |caddie|
      caddie.update_attributes(
        :first_name      => caddie.person.first_name,
        :last_name       => caddie.person.last_name,
        :phone           => caddie.person.phone,
        :email           => caddie.person.email,
        :organization_id => caddie.person.organization_id,
        :is_active       => caddie.person.is_active
      )

      caddie.person.destroy
    end

    # drop link
    remove_index       :caddies, :person_id
    remove_column      :caddies, :person_id, :integer
  end
end
