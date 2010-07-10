class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :name
      t.string :contact_person
      t.text :address
      t.string :city
      t.integer :pincode
      t.integer :phone_no
      t.string :customer_key
      t.string :auth_key
      t.string :status
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
