class CartListing
  attr_reader :cart, :listing, #:check_in, :check_out

  def initialize(cart)
    @cart = cart
    # @dates = dates
    # @check_in = dates[:check_in]
    # @check_out = dates[:check_out]
  end

  def listing
    Listing.find(cart.keys.first.to_i)
  end

  def valid?
    !no_dates_selected
  end

  def no_dates_selected
    # dates[:from].nil? ||
    # dates[:to].nil? ||
    # dates[:from].empty? ||
    # dates[:to].empty?
  end

  def date_range
    "#{check_in} - #{check_out}"
  end

  def cost_per_day
    listing.cost
  end

  def number_of_days
    Date.strptime(check_out, '%m/%d/%Y') - Date.strptime(check_in, '%m/%d/%Y')
  end

  def total_cost
    listing.cost * number_of_days
  end

  def name
    listing.name
  end

  def location
    Location.find(listing.location_id).continent
  end

end
