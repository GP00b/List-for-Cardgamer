class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.imagefile_name = "default_user.png"
    if @user.save
      flash[:success] = "ユーザー登録が完了しました"
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render("users/new")
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー編集が完了しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー編集に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    
    flash[:success] = '正常に退会しました'
    redirect_to root_url
  end
  
  private
  
  def ensure_correct_user
    if current_user.id != params[:id].to_i
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :imagefile_name, :email, :password, :password_confirmation)
  end
  
  def logged_in?
    !!current_user
  end
  
end