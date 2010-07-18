class AddIsDeletedToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :is_deleted, :boolean, :default => false
    add_column :customers, :is_deleted, :boolean, :default => false
  end

  def self.down
    remove_column :products, :is_deleted
    remove_column :customers, :is_deleted
  end
end
