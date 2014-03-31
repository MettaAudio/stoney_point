class CreateHousingGolfer < ActiveRecord::Migration
  def change
    create_table :golfers_housings, :id => false do |t|
      t.references :housing
      t.references :golfer
    end
    remove_column :housings, :golfer_id, :integer
    add_index :golfers_housings, [:housing_id, :golfer_id]
    add_index :golfers_housings, :golfer_id
  end
end
