class ProductsController < ApplicationController
  before_filter :require_user
  before_filter :require_admin_user, :only => [:new, :create, :destroy, :assign_users, :remove_user]
  
  def index
    @products = current_user.products.list
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      @product.accessibles.create(:user_id => current_user.id)
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

  def assign_users
    @product = Product.find(params[:id])
    if params[:commit].eql?('Assign')
      @accessible = @product.accessibles.build(params[:accessible])
      if @accessible.save
	flash[:notice]= "User was successfully assigned."
      else
	flash[:notice]= "Problem in User assign."	
      end
      redirect_to assign_users_path(:id => @product.id)
    end
  end

  def remove_user
    @product = Product.find(params[:product_id])
    accessible = @product.accessibles.find(params[:id].to_i)
    if accessible.destroy
      flash[:notice] = "Successfully removed"
    else
      flash[:error] = "Problem in removing"
    end
    redirect_to assign_users_path(:id => @product.id)
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
