class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_admin_user, :only => [:new, :create, :index]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default new_user_session_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    if !@user.eql?(@current_user) && !@current_user.is_admin?
      render :text => "You are not authorized to access this page"
    end
  end

  def edit
    @user = User.find(params[:id])
    if !@user.eql?(@current_user) && !@current_user.is_admin?
      render :text => "You are not authorized to access this page"
    end
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_path(@user)
    else
      render :action => :edit
    end
  end
  
  def index
    @users = User.all
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "User successfully deleted"
      redirect_to users_path
    else
      flash[:error] = "Problem in user deletion"
      redirect_to users_path
    end
  end
end
