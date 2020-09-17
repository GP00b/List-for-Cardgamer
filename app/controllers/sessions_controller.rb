class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = "ログインしました"
      redirect_to root_url
    else
      @email = params[:session][:email]
      @password = params[:session][:password]
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      @error_message = "メールアドレスまたはパスワードが間違っています"
      return false
    end
  end
end

