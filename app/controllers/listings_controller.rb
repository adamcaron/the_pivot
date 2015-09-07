class ListingsController < ApplicationController

  def new
    @listing = Listing.new
    @locations = Location.all
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      current_user.roles << Role.find_by(title: "business_admin")
      current_user.update!(host_id: current_user.id)
      current_user.save
      flash[:notice] = "Listing created!"
      redirect_to dashboard_path
    else
      flash[:error] = "Invalid input - Please try creating listing again"
      render '/listings/new.html.erb'
    end
  end

  def show
    @listing = Listing.find(params[:id])
    build_google_markers(@listing)
  end

  def index
  end

  def search_results
    # session[:dates] = { to: params[:to], from: params[:from] }
    if !cart_listing.valid?
      flash[:invalid_search] = "Invalid search. Please try again"
      redirect_to root_path
    else
      @search_results = Listing.all.where location_id: params[:location]
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update!(listing_params)
    if @listing.save
      current_user.update!(host_id: current_user.id)
      flash[:notice] = "Listing updated!"
      redirect_to dashboard_path
    else
      flash[:error] = "Listing not updated - Please try updating listing again"
      render '/listings/edit.html.erb'
    end
  end

  def build_google_markers(data)
    @hash = Gmaps4rails.build_markers(data) do |listing, marker|
      marker.lat listing.lat
      marker.lng listing.long
      marker.infowindow "<a id='map-links' href='#{listing_url(listing)}'>#{listing.name}</a>"
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :description, :cost, :location_id, :image, :gmaps, :host_id, :lat, :long)
  end
end
