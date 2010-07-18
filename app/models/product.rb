class Product < ActiveRecord::Base
  has_many :customers

  validates_presence_of :name, :status

  named_scope :list , :conditions => ["is_deleted = ?", false]
end
