class TasksController < ApplicationController
  def index
    @tasks = Task.order(:id).all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    return redirect_to :index unless current_user and current_user.is_admin?
	@task = Task.new
  end
  
  def create
    return redirect_to :index unless current_user and current_user.is_admin?
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
    return redirect_to :index unless current_user and current_user.is_admin?
	@task = Task.find(params[:id]) 
  end
  
  def update
    return redirect_to :index unless current_user and current_user.is_admin?
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
    return redirect_to :index unless current_user and current_user.is_admin?
    @task = Task.find(params[:id])
    @task.destroy
 
    redirect_to tasks_path
  end
  
  private
    def task_params
      params.require(:task).permit(:title, :content)
    end
	
end
