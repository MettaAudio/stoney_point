class AddEmailAndCommentsToCaddie < ActiveRecord::Migration
  def change
    add_column :caddies, :email, :string
    add_column :caddies, :comments, :text
  end
end
