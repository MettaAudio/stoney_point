class ChangeGolfToStringForCaddie < ActiveRecord::Migration
  def up
    change_column :caddies, :golf, :string
  end

  def down
    change_column :caddies, :golf, :boolean
  end
end
