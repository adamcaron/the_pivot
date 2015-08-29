class CartsController < ApplicationController
  attr_reader :cart

  def show
    if cart.contents.empty?
      flash[:empty_cart] = "You're cart is empty. Please add to cart before going to the cart page"
      redirect_to root_path
    elsif session[:dates].values.include?(nil)
      flash[:empty_cart] = "You don't have any dates selected. Please select dates"
      redirect_to root_path
    end
  end

  # there is a cart helper_method in the application controller. is the line below def create or helper_method redundant?
  def create
    @cart ||= Cart.new(session[:cart])
    listing = Listing.find(params[:listing_id])
    session[:cart].clear unless session[:cart].nil?
    cart.add_listing(listing.id)
    session[:cart] = cart.contents
    redirect_to cart_path
  end

  def destroy
    session[:cart] = cart.contents.clear
    flash[:remove] = "Successfully removed from cart."
    redirect_to root_path
  end
end
