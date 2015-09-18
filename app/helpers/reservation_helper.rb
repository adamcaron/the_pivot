module ReservationHelper

  def listing
    Listing.find(params[:listing_id])
  end

  def date_range
    "#{params[:check_in]} - #{params[:check_out]}"
  end

  def cost_per_day
    listing.cost
  end

  def number_of_days
    Date.strptime(params[:check_out], '%m/%d/%Y') - Date.strptime(params[:check_in], '%m/%d/%Y')
  end

  def total_cost
    listing.cost * number_of_days
  end
end
