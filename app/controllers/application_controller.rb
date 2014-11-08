class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end  
  
  def flash_now_errors(elem)
	if elem.errors.any?
	  i = 0
	  elem.errors.full_messages.each do |msg|
	    flash.now["danger_#{i}"] = msg
		i += 1
	  end
	end
  end
  
end
