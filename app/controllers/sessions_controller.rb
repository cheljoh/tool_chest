class SessionsController < ApplicationController

  def create
    @user = User.find_by(username: params[:session][:username])
    @user && @user.authenticate(params[:session][:password]) #user exists in db and pw is ok
    session[:user_id] = @user.id

    #if @user && @user.authenticate(params[:session][:password]) #user exists in db and pw is ok
    # session[:user_id] = @user.id #could have this in model, but in string for the path. Would call user.dashboard path
      # if user.admin?
        #redirect to admin_dashboard_path
      #else
        #redirect_to user_path(user)
    #else
      #render:new

    redirect_to @user
  end

  def new

  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
