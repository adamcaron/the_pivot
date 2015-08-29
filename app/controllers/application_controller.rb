class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def cart_listing
    @cart_listing ||= CartListing.new(session[:cart], session[:dates])
  end
  helper_method :cart_listing

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_admin?
    current_user && current_user.admin?
  end
  helper_method :current_admin?

  def generate_cart
    @cart ||= Cart.new(session[:cart])
  end
  before_action :generate_cart

end
