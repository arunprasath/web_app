class ProductsController < ApplicationController
  active_scaffold :product do |config|
    config.columns = [:name, :description, :developed_by, :status, :created_at, :updated_at]
    list.sorting = {:name => 'ASC'}
    #config.show.link = false 
  end
end
