class CartListing
  attr_reader :cart, :dates, :listing

  def initialize(cart, dates)
    @cart = cart
    @dates = dates
  end

  def listing
    Listing.find(cart.keys.first.to_i)
  end

  def valid?
    !no_dates_selected
  end

  def no_dates_selected
    dates[:from].nil? ||
    dates[:to].nil? ||
    dates[:from].empty? ||
    dates[:to].empty?
  end

  def date_range
    "#{dates["from"]} - #{dates["to"]}"
  end

  def cost_per_day
    listing.cost
  end

  def number_of_days
    (Date.strptime(dates["to"], '%m/%d/%Y') - Date.strptime(dates["from"], '%m/%d/%Y')).to_i
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
