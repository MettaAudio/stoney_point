class AddUniformPriceToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :uniform_price, :integer
  end
end
