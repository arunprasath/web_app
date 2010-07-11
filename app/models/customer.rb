class Customer < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :name,:address, :phone_no, :customer_key, :auth_key, :status
end
