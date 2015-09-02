class ListingsController < ApplicationController

  def new
    @listing = Listing.new
    @locations = Location.all
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      current_user.roles.first.update!(title: "business_admin")
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
    session[:dates] = { to: params[:to], from: params[:from] }
    if !cart_listing.valid?
      flash[:invalid_search] = "Invalid search. Please try again"
      redirect_to root_path
    else
      @search_results = Listing.all.where location_id: params[:location]
      build_google_markers(@listings)
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
    params.require(:listing).permit(:name, :description, :cost, :location_id, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :gmaps, :host_id, :lat, :long)
  end
end
