class Product < ActiveRecord::Base
  has_many :customers
  has_many :users, :through => :accessibles
  has_many :accessibles, :dependent => :destroy

  validates_presence_of :name, :status

  validates_format_of :name, :with => /^[a-zA-Z ]+$/x
  validates_format_of :developed_by, :with => /^[a-zA-Z ]+$/x

  named_scope :list , :conditions => ["is_deleted = ? AND status = 'Active'", false]
  named_scope :inactive_list , :conditions => ["is_deleted = ? AND status = 'Inactive'", false]
end
