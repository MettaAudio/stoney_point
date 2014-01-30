class ChangeCaddiePhoneToString < ActiveRecord::Migration
  def change
    change_column :caddies, :phone, :string
  end
end
