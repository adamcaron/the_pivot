class ApplicationController < ActionController::Base
  before_action :generate_cart
  before_action :authorize!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger

  def find_listing
    if params[:listing_id]
      Listing.find(params[:listing_id])
    else
      Listing.find(cookies[:listing_id])
    end
  end

  def delete_pending_reservation
    cookies.delete :check_in
    cookies.delete :check_out
    cookies.delete :listing_id
  end

  def cart_listing
    @cart_listing ||= CartListing.new(session[:cart])
  end
  helper_method :cart_listing

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def generate_cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def authorize!
    redirect_to root_url, danger: "You don't know me." unless authorized?
  end

  private

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end
end
