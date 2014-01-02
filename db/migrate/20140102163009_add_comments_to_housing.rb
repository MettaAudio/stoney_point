class AddCommentsToHousing < ActiveRecord::Migration
  def change
    add_column :housings, :comments, :text
  end
end
