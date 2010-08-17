# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  layout 'home'
  
  #ActiveScaffold.set_defaults do |config| 
  #  config.ignore_columns.add [:created_at, :updated_at]
  #end

  def activate
    model = params[:class]
    record = model.humanize.constantize.find params[:id]
    if record.update_attribute(:status, 'Active')
      flash[:notice]= "#{record.class} was successfully Activated."
    else
      flash[:notice]= "Problem in update"
    end
    redirect_to :controller => model.pluralize, :action => 'index' if !model.eql?('customer')
    redirect_to :controller => model.pluralize, :action => 'index', :product_id => record.product_id if model.eql?('customer')  
  end

  def in_activate
    model = params[:class]
    record = model.humanize.constantize.find params[:id]
    if record.update_attribute(:status, 'Inactive')
      flash[:notice]= "#{record.class} was successfully Inactivated."
    else
      flash[:notice]= "Problem in update"
    end
    redirect_to :controller => model.pluralize, :action => 'index' if !model.eql?('customer')
    redirect_to :controller => model.pluralize, :action => 'index', :product_id => record.product_id if model.eql?('customer')  
  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end

  def require_admin_user
    if current_user.present? && !current_user.is_admin?
      render :text => "You are not authorized user"
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end
    
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
