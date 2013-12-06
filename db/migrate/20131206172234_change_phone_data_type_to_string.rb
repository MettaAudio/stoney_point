class ChangePhoneDataTypeToString < ActiveRecord::Migration
  def change
    change_column :volunteers, :primary_phone, :string
    change_column :volunteers, :secondary_phone, :string
  end
end
