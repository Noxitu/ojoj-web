class UsersController < ApplicationController

  def login
    redirect_to root_url if current_user
  end
  
  def login_attempt
    redirect_to root_url if current_user
	
    user = User.auth(params[:name], params[:password])
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
    redirect_to root_url if current_user
  end
  
  def register_attempt
    redirect_to root_url if current_user
	
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
end
