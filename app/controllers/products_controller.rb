class ProductsController < ApplicationController
  before_filter :require_user
  before_filter :require_admin_user, :only => [:new, :create, :destroy]
  
  def index
    @products = Product.list
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = "Product was ssuccessfully added"
      redirect_to products_path
    else
      flash[:error] = "Problem in Product creation"
      render :action => 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])    
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product was successfully updated"
      redirect_to products_path
    else
      flash[:error] = "Problem in Product update"
      render :action => 'edit'
    end    
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.update_attributes(:is_deleted => true) 
      flash[:notice] = "Product was successfully deleted"
      redirect_to products_path            
    else
      flash[:error] = "Problem in product deletion"
      redirect_to products_path
    end
  end

  #active_scaffold :product do |config|
  #  config.columns = [:name, :description, :developed_by, :status, :customers]
  #  list.sorting = {:name => 'ASC'}
  #  #config.show.link = false 
  #  config.create.columns.exclude :customers
  #  config.update.columns.exclude :customers
  #  #config.create.link = current_user
  #  config.nested.add_link("Customer List", [:customers])
  #end
  
  #def conditions_for_collection
  #end
end
