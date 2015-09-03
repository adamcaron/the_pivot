class WelcomeController < ApplicationController

  def index
    @locations = Location.all
    @featured_listings = Listing.all.sample(3)
  end
end
