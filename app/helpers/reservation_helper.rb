module ReservationHelper

  def listing
    if params[:listing_id]
      Listing.find(params[:listing_id])
    else
      Listing.find(cookies[:listing_id])
    end
  end

  def date_range
    "#{check_in_date} - #{check_out_date}"
  end

  def cost_per_day
    listing.cost
  end

  def number_of_days
    Date.strptime(check_out_date, '%m/%d/%Y') - Date.strptime(check_in_date, '%m/%d/%Y')
  end

  def total_cost
    listing.cost * number_of_days
  end

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
