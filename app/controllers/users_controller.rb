class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      @user.roles << Role.find_by(title: "registered_user")
      flash[:notice]    = "Welcome back #{@user.username}!"
      redirect_to new_reservation_path
    else
      flash[:error] = "Invalid input - Please try creating user again"
      render :new
    end
  end

  def show
    if current_user == nil
      redirect_to '/404'
    else
      @listings = Listing.where(host_id: current_user.id)
    end
  end

  def edit
    if current_user.id == params[:id].to_i
      @user = User.find(current_user.id)
    else
      flash[:error] = "That's not you!"
      if current_admin?
        redirect_to admin_dashboard_path
      else
        redirect_to profile_path
      end
    end
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(username: params[:user][:username],
                    password: params[:user][:password])
      flash[:notice] = "Profile updated!"
      redirect_to dashboard_path
    else
      flash[:error] = "Invalid input - Please try updating listing again"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
