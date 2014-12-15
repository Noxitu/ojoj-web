class UsersController < ApplicationController

  def login
    return redirect_to root_url if current_user
  end
  
  def login_attempt
    return redirect_to root_url if current_user
	
    user = User.auth(params[:name], params[:password])
	
	puts user.inspect
	
	if user
	  session[:user_id] = user.id
	  flash[:success] = "Loged as #{user.name}"
	  redirect_to root_url
	else
	  flash.now[:danger] = 'Invalid login data'
	  render :login
	end
  end
  
  def register
    return redirect_to root_url if current_user
  end
  
  def register_attempt
    return redirect_to root_url if current_user
	
    user = User.new(params.permit(:name,:password))
	if user and user.save
	  session[:user_id] = user.id
	  flash[:success] = "Loged as #{user.name}"
      redirect_to root_url
	else
	  flash.now[:danger] = 'Invalid register data'
	  render register
	end
  end
  
  def logout
    session.delete(:user_id)
	flash[:info_loged_out] = "You have successfully logged out."
    redirect_to root_url
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit_permissions
    return redirect_to root_url unless current_user and current_user.permissions.exists?(:name => 'Manage permissions')
    @user = User.find(params[:id])
	@permissions = Permission.all
  end
  
  def update_permissions
    return redirect_to root_url unless current_user and current_user.permissions.exists?(:name => 'Manage permissions')
    @user = User.find(params[:id])
	@user.permissions.clear
	Permission.all.each do |p|
	  @user.permissions << p if params[:permissions].has_key?(p.name)
	end
	@user.save
	
	redirect_to @user
  end
end
