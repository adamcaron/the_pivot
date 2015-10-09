class ReservationsController < ApplicationController

  def new
    if params[:listing_id]
      cookies[:check_in]   = params[:check_in]
      cookies[:check_out]  = params[:check_out]
      cookies[:listing_id] = params[:listing_id]
      @listing = find_listing
    else
      @listing = find_listing
    end
  end

  def create
    if current_user
      Reservation.create!(user_id:     current_user.id,
                          status:      1,
                          listing_id:  params[:listing_id],
                          check_in:    Date.strptime(check_in_date, '%m/%d/%Y'),
                          check_out:   Date.strptime(check_out_date, '%m/%d/%Y'),
                          total_cost:  params[:total_cost].to_f)

      flash[:notice] = "Reservation was successfully placed!"
      delete_pending_reservation
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

  private

  def check_in_date
    if params[:check_in]
      params[:check_in]
    else
      cookies[:check_in]
    end
  end

  def check_out_date
    if params[:check_out]
      params[:check_out]
    else
      cookies[:check_out]
    end
  end
end
