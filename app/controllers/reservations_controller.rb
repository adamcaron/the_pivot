class ReservationsController < ApplicationController

  def create
    if current_user
      listing = Listing.find(params[:listing_id])
      number_of_days = Date.strptime(session[:dates]["to"], '%m/%d/%Y') - Date.strptime(session[:dates]["from"], '%m/%d/%Y')
      total_cost = listing.cost * number_of_days
      current_user.reservations.create(user_id: current_user.id,
                                       status: 1,
                                       listing_id: listing.id,
                                       start_date: session[:dates]["from"],
                                       end_date: session[:dates]["to"],
                                       total_cost: total_cost)

      session[:cart].clear
      session[:dates].clear
      flash[:notice] = "Reservation was successfully placed!"
      redirect_to reservations_path
    else
      flash[:notice] = "You must be logged in to checkout!"
      redirect_to login_path
    end
  end

  def index
    @reservations = Reservation.where(user_id: current_user.id)
  end

  def show
    @reservation = Reservation.find(params[:id])
  end
end
