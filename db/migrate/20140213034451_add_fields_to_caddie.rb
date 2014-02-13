class AddFieldsToCaddie < ActiveRecord::Migration
  def change
    add_column :caddies, :organization_id, :integer
    add_column :caddies, :golf, :boolean
    add_column :caddies, :course, :string
    add_column :caddies, :rules, :string
  end
end
