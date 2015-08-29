class ReservationsController < ApplicationController

  def create
    if current_user
      current_user.reservations.create(user_id: current_user.id,
                                       status: 1,
                                       listing_id: cart_listing.listing.id,
                                       start_date: session[:dates]["from"],
                                       end_date: session[:dates]["to"],
                                       total_cost: cart_listing.total_cost)

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
