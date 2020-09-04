class UsersController < ApplicationController
  
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
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/")
    else
      render("users/new")
    end
  end
  
  def edit
    
  end
  
  def withdrawal
    
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
end
