class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "You have been successfully CREATED!!!!"
       redirect_to root_path#user_path(@user)

    else
      render :new
    end
  end
end
