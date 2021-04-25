class SessionsController < ApplicationController
  
  def new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_to users_path, notice: "#{@user.name}としてログインしました"
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: "ログアウトしました"
  end

end
