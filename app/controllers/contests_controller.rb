class ContestsController < ApplicationController
  def index
    return redirect_to :index unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
    @contests = Contest.order(:id).all
  end
  
  def show
    return redirect_to :index unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
    @contest = Contest.find(params[:id])
  end
  
  def new
    return redirect_to :index unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
	@contest = Task.new
  end
  
  def create
    return redirect_to :index unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
    @task = Task.new(task_params)
 
    if @task.save
	  flash[:success] = "Task \"#{@task.title}\" created."
      redirect_to @task
    else
	  flash_now_errors @task
      render 'new'
    end
  end
  
  def edit
    return redirect_to :index unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
	@task = Task.find(params[:id]) 
  end
  
  def update
    return redirect_to :index unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
    @task = Task.find(params[:id])
 
    if @task.update(task_params)
	  flash[:success] = "Task \"#{@task.title}\" saved."
      redirect_to @task
    else
	  flash_now_errors @task
      render 'edit'
    end
  end
  
  def destroy
    return redirect_to :index unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
    @task = Task.find(params[:id])
    @task.destroy
 
    redirect_to tasks_path
  end
  
  private
    def task_params
      params.require(:task).permit(:title, :content)
    end
	
end
