class AddIsActiveToCaddie < ActiveRecord::Migration
  def change
    add_column :caddies, :is_active, :boolean
  end
end
