class ChangePhoneDataTypeToBigInt < ActiveRecord::Migration
  def change
    change_column :volunteers, :primary_phone, :bigint
    change_column :volunteers, :secondary_phone, :bigint
  end
end
