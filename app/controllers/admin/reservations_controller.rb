class Admin::ReservationsController < Admin::BaseController

  def index
    @reservations = Reservation.where(nil)
    filtering_params(params).each do |key, value|
      @reservations = @reservations.public_send(key, value) if value.present?
    end

  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(status: params[:reservation][:status].to_i)
    redirect_to admin_reservations_path
  end

  private

  def filtering_params(params)
    params.slice(:status)
  end

end
