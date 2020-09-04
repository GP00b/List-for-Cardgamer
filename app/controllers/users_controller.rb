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
  
  def login_form
    
  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  
  def withdrawal
    
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
end
