class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy]
  before_action :set_task, only: [:edit, :update]
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に入力されました'
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = 'Taskの入力に失敗しました'
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = '更新しました。'
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = '更新に失敗しました。'
      render 'edit'
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'Taskは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
    def set_task
      @task = Task.find(params[:id])
    end
    
    def task_params
      params.require(:task).permit(:content,:status)
    end
    
    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to root_path
      end
    end
end
