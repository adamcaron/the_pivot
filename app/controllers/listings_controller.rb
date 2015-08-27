class ListingsController < ApplicationController
  def show
    @listing = Listing.find(params[:id].to_i)
    build_google_markers(@listing)
  end

  def index
    @listings = Listing.all
    build_google_markers(@listings)
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :listing_cost,
                                    :destination_id, :image,
                                    :lat, :long)
  end

  def build_google_markers(data)
    @hash = Gmaps4rails.build_markers(data) do |listing, marker|
      marker.lat listing.lat
      marker.lng listing.long
      marker.infowindow "<a id='map-links' href='#{listing_url(listing)}'>#{listing.name}</a>"
    end
  end

end
