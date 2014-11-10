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
  
  def clear
    return redirect_to root_url unless current_user and current_user.is_admin?
	
    @sub = Sub.find(params[:id])
	@sub.result = @sub.cpu_used = @sub.mem_used = nil
	@sub.save
	
	redirect_to @sub
  end
  
  def tester_api_get
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
  
  def tester_api_set
    return redirect_to root_url unless current_user and current_user.is_tester?
	
    @sub = Sub.find(params[:id])
	@sub.result = params[:result]
	@sub.cpu_used = params[:cpu] ? params[:cpu].to_i/1000.0 : nil
	@sub.mem_used = params[:mem] ? params[:mem].to_i/1024.0 : nil
	@sub.save
	
	render plain: ''
  end
  
  def ajax
    if params[:id]
		@sub = Sub.find(params[:id])
		return render json: [ [@sub.id, render_to_string(@sub)] ] if @sub.updated_at.to_i > params[:since].to_i
	else
		@subs = Sub.where('updated_at > ?', params[:since].to_i)
		return render json: @subs.map {|s| [s.id, render_to_string(s)] }
	end
    render json: []
  end
end
