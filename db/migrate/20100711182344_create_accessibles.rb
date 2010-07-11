class CreateAccessibles < ActiveRecord::Migration
  def self.up
    create_table :accessibles do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :accessibles
  end
end
