class ReservationsController < ApplicationController

  def new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    if current_user
      Reservation.create!(user_id:     current_user.id,
                          status:      1,
                          listing_id:  params[:listing_id],
                          check_in:    Date.strptime(params[:check_in], '%m/%d/%Y'),
                          check_out:   Date.strptime(params[:check_out], '%m/%d/%Y'),
                          total_cost:  params[:total_cost].to_f)

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
