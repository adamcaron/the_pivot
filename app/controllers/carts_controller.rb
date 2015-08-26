class CartsController < ApplicationController
  def create
    listing = Listing.find(params[:listing_id])
    cart.add_listing(listing)
    session[:cart] = cart.data
    redirect_to cart_path
  end

  def index
    @cart_trips = cart.trips
  end

  def increment
    listing = Listing.find(params[:id])
    cart.add_listing(listing)
    session[:cart] = cart.data
    redirect_to cart_path
  end

  def decrement
    listing = Listing.find(params[:id])
    cart.decrease_trip(listing)
    session[:cart] = cart.data
    redirect_to cart_path
  end

  def destroy
    @listing = Listing.find(params[:id])
    cart.remove_listing(@listing)
    session[:cart] = cart.data
    flash[:remove] = "Successfully removed #{@listing.name} from cart."
    redirect_to cart_path
  end
end
