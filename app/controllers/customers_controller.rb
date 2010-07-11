class CustomersController < ApplicationController
  active_scaffold :customer do |config|
    config.columns = [:name, :contact_person, :address, :city, :pincode, :phone_no, :customer_key, :auth_key, :status, :created_at, :updated_at]
    list.sorting = {:name => 'ASC'}
    #config.columns[:product_id].label = "Product"
    #config.show.link = false 
    config.create.columns.exclude :customer_key
    config.update.columns.exclude :customer_key
    config.nested.add_link("Customer List", [:customers])
  end
end
