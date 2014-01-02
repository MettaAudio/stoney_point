class AddCommentsToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :comments, :text
  end
end
