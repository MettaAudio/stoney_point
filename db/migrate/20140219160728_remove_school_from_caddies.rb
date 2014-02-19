class RemoveSchoolFromCaddies < ActiveRecord::Migration
  def change
    remove_column :caddies, :school, :string
  end
end
