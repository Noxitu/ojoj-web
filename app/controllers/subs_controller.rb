class SubsController < ApplicationController

  def new
    return redirect_to root_url unless current_user
  end
  
  def create
    return redirect_to root_url unless current_user
	
	unless params[:task_id].to_i > 0
	  flash.now[:danger] = 'You must select task.'
      return render 'new'
	end 
	
	@task = Task.find(params[:task_id])
    uploaded_io = params[:src]
	
	unless uploaded_io and File.exists? uploaded_io.tempfile
      flash.now[:danger] = 'No file uploaded.'
      return render 'new'
	  
	end 
	
    @sub = Sub.new( { :task_id => @task.id, :user_id => current_user.id, :src => uploaded_io.read } )
	if @sub.save
	  redirect_to @sub
	else
	  flash_now_errors @task
	  render 'new'
	end
  end
  
  def index
    @subs = Sub.all.order(id: :desc)
  end
  
  def show
    @sub = Sub.find(params[:id])
  end
  
  def tester_api_get
    return redirect_to root_url unless current_user and current_user.is_tester?
	
    @sub = Sub.where( result: nil ).first
	if @sub
      render plain: "#{@sub.id}\n#{@sub.task.id}\n#{@sub.src}"
	else
	  render plain: -1
	end
  end
  
  def tester_api_set
    return redirect_to root_url unless current_user and current_user.is_tester?
	
    @sub = Sub.find(params[:id])
	@sub.result = params[:result]
	@sub.save
	
	render plain: ''
  end
end
