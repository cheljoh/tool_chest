class SessionsController < ApplicationController

  def create
    @user = User.find_by(username: params[:session][:username])
    @user && @user.authenticate(params[:session][:password])
    session[:user_id] = @user.id
    redirect_to @user
  end

  def new

  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
