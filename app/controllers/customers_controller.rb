class CustomersController < ApplicationController
  before_filter :find_product, :only => [:index, :new, :edit, :create]

  def index
    @customers = @product.customers.list
    @inactive_customers = @product.customers.inactive_list
  end

  def new
    @customer = @product.customers.build
  end

  def create
    @customer = @product.customers.build(params[:customer])
    @customer.set_auth_key
    if @customer.save
      flash[:notice] = "Customer was ssuccessfully added"
      redirect_to customers_path(:product_id => @product.id)
    else
      flash[:error] = "Problem in Customer creation"
      render :action => 'new', :product_id => @product.id
    end
  end

  def edit
    @customer = Customer.find(params[:id])    
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Customer was successfully updated"
      redirect_to customers_path(:product_id => @customer.product.id)
    else
      flash[:error] = "Problem in Customer update"
      render :action => 'edit'
    end    
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(:is_deleted => true) 
      flash[:notice] = "Customer was successfully deleted"
      redirect_to customers_path(:product_id => @customer.product.id)            
    else
      flash[:error] = "Problem in customer deletion"
      redirect_to customers_path(:product_id => @customer.product.id)
    end
  end

  protected
  
  def find_product
    @product = Product.find(params[:product_id])
  end

#  active_scaffold :customer do |config|
#    config.columns = [:name, :contact_person, :address, :city, :pincode, :phone_no, :customer_key, :auth_key, :status]
#    list.sorting = {:name => 'ASC'}
    #config.columns[:product_id].label = "Product"
#    config.columns[:name].label = "Customer Name"
    #config.show.link = false 
#    config.create.columns.exclude :customer_key
#    config.update.columns.exclude :customer_key
#  end
end
