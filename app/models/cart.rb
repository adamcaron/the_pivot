class Cart
  attr_reader :data

  def initialize(input_data = {})
    @data = input_data || Hash.new
  end

  def listings
    @data.map do |listing_id, quantity|
      listing = Listing.find(listing_id)
      CartListing.new(listing, quantity)
    end
  end

  def add_listing(listing)
    data[listing.id.to_s] ||= 0
    data[listing.id.to_s] += 1
  end

  def remove_listing(listing)
    data.except!(listing.id.to_s)
  end

  def decrease_listing(listing)
    if data[listing.id.to_s] && data[listing.id.to_s] > 1
      data[listing.id.to_s] -= 1
    else
      data.except!(listing.id.to_s)
    end
  end

end
