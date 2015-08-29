class CartListing
  attr_reader :cart, :dates, :listing

  def initialize(cart, dates)
    @cart = cart
    @dates = dates
    @listing = Listing.find(cart.keys.first.to_i)
  end

  def valid?
    !no_dates_selected
  end

  def no_dates_selected
    dates[:from].empty? ||
      dates[:from].nil? ||
      dates[:to].empty? ||
      dates[:to].nil?
  end

  def date_range
    "#{dates["from"]} - #{dates["to"]}"
  end

  def cost_per_day
    listing.cost
  end

  def number_of_days
    Date.strptime(dates["to"], '%m/%d/%Y') - Date.strptime(dates["from"], '%m/%d/%Y')
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
