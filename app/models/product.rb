class Product < ActiveRecord::Base
  has_many :customers
  has_many :users, :through => :accessibles
  has_many :accessibles, :dependent => :destroy

  validates_presence_of :name, :status

  named_scope :list , :conditions => ["is_deleted = ?", false]
end
