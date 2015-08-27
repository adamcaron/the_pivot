class CartsController < ApplicationController
  attr_reader :cart

  def show
    @cart ||= Cart.new(session[:cart])
    listing_id = @cart.contents.keys.first.to_i
    @listing ||= Listing.find(listing_id)
    @location ||= Location.find(@listing.location_id).continent
    @date_range = "#{session[:dates]["to"]} - #{session[:dates]["from"]}"
  end

  def create
    @cart ||= Cart.new(session[:cart])
    listing = Listing.find(params[:listing_id])
    session[:cart].clear
    cart.add_listing(listing.id)
    session[:cart] = cart.contents
    redirect_to cart_path
  end

  def destroy
    listing = Listing.find(params[:listing_id])
    cart.remove_listing(listing.id)
    session[:cart] = cart.contents
    flash[:remove] = "Successfully removed #{listing.name} from cart."
    redirect_to cart_path
  end
end
