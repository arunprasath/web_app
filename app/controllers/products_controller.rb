class ProductsController < ApplicationController
  before_filter :require_user

  active_scaffold :product do |config|
    config.columns = [:name, :description, :developed_by, :status, :created_at, :updated_at, :customers]
    list.sorting = {:name => 'ASC'}
    #config.show.link = false 
    config.create.columns.exclude :customers
    config.update.columns.exclude :customers
    #config.create.link = false  
    config.nested.add_link("Customer List", [:customers])
  end
  
  def conditions_for_collection
    
  end
end
