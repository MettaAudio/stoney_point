class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.string :time
      t.belongs_to :volunteer

      t.timestamps
    end
  end
end
