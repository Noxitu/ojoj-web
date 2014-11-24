class ApiController < ApplicationController
 
  def get
    return redirect_to root_url unless current_user and current_user.is_tester?
	
    @sub = Sub.where( result: nil ).lock.first
	if @sub
	  @sub.result = -1
	  @sub.save
      render plain: "#{@sub.id}\n#{@sub.task.id}\n#{@sub.src}"
	else
	  render plain: -1
	end
  end
  
  def set
    return redirect_to root_url unless current_user and current_user.is_tester?
	
    @sub = Sub.find(params[:id])
	@sub.result = params[:result]
	@sub.cpu_used = params[:cpu] ? params[:cpu].to_i/1000.0 : nil
	@sub.mem_used = params[:mem] ? params[:mem].to_i/1024.0 : nil
	@sub.save
	
	render plain: ''
  end
 
end
