class CreateCaddies < ActiveRecord::Migration
  def change
    create_table :caddies do |t|
      t.string :first_name
      t.string :last_name
      t.integer :phone
      t.string :school
      t.belongs_to :golfer

      t.timestamps
    end
  end
end
