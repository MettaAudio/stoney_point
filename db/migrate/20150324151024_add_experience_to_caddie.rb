class AddExperienceToCaddie < ActiveRecord::Migration
  def change
    add_column :caddies, :experience_as_caddie, :boolean
    add_column :caddies, :age, :integer
    add_column :caddies, :waiver, :boolean
  end
end
