class CreateWorkDays < ActiveRecord::Migration
  def change
    create_table :work_days do |t|
      t.datetime :time
      t.belongs_to :job
      t.timestamps
    end
  end
end
