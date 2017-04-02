class UsersController < ApplicationController
  before_action :set_user, only:[:show]
  before_action :require_user_logged_in, only: [:show]
  
  def show
    if logged_in?
      @user = current_user
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to @user
    else
      flash[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
