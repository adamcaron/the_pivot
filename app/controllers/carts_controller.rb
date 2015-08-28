class CartsController < ApplicationController
  attr_reader :cart

  def show
    @cart ||= Cart.new(session[:cart])

    unless @cart.contents.empty?
      listing_id = @cart.contents.keys.first.to_i
      @listing ||= Listing.find(listing_id)

      @location ||= Location.find(@listing.location_id).continent
      @date_range = "#{session[:dates]["from"]} - #{session[:dates]["to"]}"

      number_of_days = Date.strptime(session[:dates]["to"], '%m/%d/%Y') - Date.strptime(session[:dates]["from"], '%m/%d/%Y')
      @total_cost = @listing.cost * number_of_days
    end
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
