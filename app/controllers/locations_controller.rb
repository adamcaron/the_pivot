class LocationsController < ApplicationController
before_action :all_locations, only: [:index, :show]

  def index

  end

  def show

  @location = Location.find(params[:id])
  @trips = @location.trips
  end


  def all_locations
  @locations = Location.all
  end

end
