class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    if login(email, password)
      flash[:notice] = "ログインしました"
      redirect_to root_url
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:session][:email]
      @password = params[:session][:password]
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to root_url
  end
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
