class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name

      t.timestamps
    end

    change_table :volunteers do |t|
      t.belongs_to :organization
    end
  end
end
