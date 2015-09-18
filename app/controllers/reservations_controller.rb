class ReservationsController < ApplicationController

  def new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    if current_user
      current_user.reservations.create(user_id:     current_user.id,
                                       status:      1,
                                       listing_id:  params[:listing_id],
                                       start_date:  params[:check_in],
                                       end_date:    params[:check_out],
                                       total_cost:  params[:total_cost])

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
