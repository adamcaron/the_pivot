class ListingsController < ApplicationController
  def show
    @listing = Listing.find(params[:id])
    build_google_markers(@listing)
  end

  def index
    @search_results = Listing.all.where location_id: params[:location]
    build_google_markers(@listings)
  end

  def build_google_markers(data)
    @hash = Gmaps4rails.build_markers(data) do |listing, marker|
      marker.lat listing.lat
      marker.lng listing.long
      marker.infowindow "<a id='map-links' href='#{listing_url(listing)}'>#{listing.name}</a>"
    end
  end
end
