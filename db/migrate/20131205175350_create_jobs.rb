class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.belongs_to :committee
      t.belongs_to :volunteer

      t.timestamps
    end
  end
end
