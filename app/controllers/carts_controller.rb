class CartsController < ApplicationController
  attr_reader :cart

  def show
    redirect_to root_path if cart.contents.empty?
  end

  def create
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
