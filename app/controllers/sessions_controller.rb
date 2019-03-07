class SessionsController < ApplicationController
  def new
  end

  def create
    #binding.pry
    #user = User.find_by(email: params[:session][:email])
    #if user && user.authenticate(params[:session][:password])
    #
    #user = User.find_by(email_params) # これは通る
    #user = User.find_by(email: email_params) # これはエラーになる
    #if user && user.authenticate(password_params) # これはエラーになる
    #
    user = User.find_by(email: email_params[:email]) # 回答例
    if user && user.authenticate(password_params[:password]) # 回答例
      log_in user
      redirect_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end

  private
    # これは意味ある？
    def email_params
      params.require(:session).permit(:email)
    end
    # これは意味ある？
    def password_params
      params.require(:session).permit(:password)
    end

    def log_in(user)
      session[:user_id] = user.id
    end

    def log_out
      session.delete(:user_id)
      @current_user = nil
    end
end
