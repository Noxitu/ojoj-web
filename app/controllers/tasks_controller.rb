class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    redirect_to :index unless current_user and current_user.is_admin?
	@task = Task.new
  end
  
  def create
    redirect_to :index unless current_user and current_user.is_admin?
    @task = Task.new(task_params)
 
    if @task.save
	  flash[:success] = "Task \"#{@task.title}\" created."
      redirect_to @task
    else
	  flash_now_errors
      render 'new'
    end
  end
  
  def edit
    redirect_to :index unless current_user and current_user.is_admin?
	@task = Task.find(params[:id]) 
  end
  
  def update
    redirect_to :index unless current_user and current_user.is_admin?
    @task = Task.find(params[:id])
 
    if @task.update(task_params)
	  flash[:success] = "Task \"#{@task.title}\" saved."
      redirect_to @task
    else
      render 'edit'
    end
  end
  
  def destroy
    redirect_to :index unless current_user and current_user.is_admin?
    @task = Task.find(params[:id])
    @task.destroy
 
    redirect_to tasks_path
  end
  
  private
    def task_params
      params.require(:task).permit(:title, :content)
    end
	
  private
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
