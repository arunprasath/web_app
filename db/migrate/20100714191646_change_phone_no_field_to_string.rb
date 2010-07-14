class ChangePhoneNoFieldToString < ActiveRecord::Migration
  def self.up
    change_column :customers, :phone_no, :string
    change_column :customers, :pincode, :string
  end

  def self.down
    change_column :customers, :phone_no, :integer
    change_column :customers, :pincode, :integer
  end
end
