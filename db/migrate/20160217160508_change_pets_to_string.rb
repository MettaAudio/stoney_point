class ChangePetsToString < ActiveRecord::Migration
  def up
    change_column :housings, :pets, :string
  end

  def down
    change_column :housings, :pets, :boolean
  end
end
