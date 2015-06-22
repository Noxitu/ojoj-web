class GroupsController < ApplicationController
  def index
    return redirect_to :root unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
    @groups = Group.order(:id).all
  end
  
  def show
    return redirect_to :root unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
    @group = Group.find(params[:id])
  end
  
  def new
    return redirect_to :root unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
	@group = Group.new
  end
  
  def create
    return redirect_to :root unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
    @group = Group.new(group_params)
 
    if @group.save
	  flash[:success] = "Group \"#{@group.name}\" created."
      redirect_to @group
    else
	  flash_now_errors @group
      render 'new'
    end
  end
  
  def edit
    return redirect_to :root unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
	@group = Group.find(params[:id]) 
  end
  
  def update
    return redirect_to :root unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
    @group = Group.find(params[:id])
 
    if @group.update(group_params)
	  flash[:success] = "Group \"#{@group.name}\" saved."
      redirect_to @group
    else
	  flash_now_errors @group
      render 'edit'
    end
  end
  
  def destroy
    return redirect_to :root unless current_user and current_user.permissions.exists?( :name => 'Manage tasks' )
    @group = Group.find(params[:id])
    @group.destroy
 
    redirect_to groups_path
  end
  
  private
    def group_params
      params.require(:group).permit(:name)
    end
	
end
