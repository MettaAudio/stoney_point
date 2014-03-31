class AddEmailToGolfers < ActiveRecord::Migration
  def change
    add_column :golfers, :email, :string
  end
end
