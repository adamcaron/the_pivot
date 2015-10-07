class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice]    = "Welcome back #{@user.username}!"
      send_to_checkout_or_homepage
    else
      flash[:error] = "Invalid login credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def send_to_checkout_or_homepage
    if params[:listing_id]
      redirect_to new_reservation_path
    else
      redirect_to root_path
    end
  end
end
