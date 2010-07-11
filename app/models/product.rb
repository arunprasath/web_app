class Product < ActiveRecord::Base
  has_many :customers

  validates_presence_of :name, :status
end
