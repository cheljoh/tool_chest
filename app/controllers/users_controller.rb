class UsersController < ApplicationController

  def index

  end

  def new

  end

  def create
    user = User.create(user_params) #could do user.new, then if user.save redirect, else render: new. Probably want ivar
    session[:user_id] = user.id
    redirect_to user
  end

  def show
    @user = current_user
  end

private

  def user_params
    params.require(:user).permit(:username, :password) #no role bc we dont want user to change it
  end
end
