class TripsController < ApplicationController
  def show
    @extras = Extra.all
  end

    # WIP - update total cost of trip when there are extras
    # trip.extras.each { |extra| trip.total_cost += extra.cost } if trip.extras

end
