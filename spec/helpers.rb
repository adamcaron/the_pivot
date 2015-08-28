module Helpers

  def help
    :available
  end

  def create_listings
    3.times do |i|
      business_admin = User.find_or_create_by!(username: "business_admin_#{i}", password: 'password')
      business_admin.update!(host_id: business_admin.id)
      Listing.find_or_create_by!(location_id:          4,
                      cost:                 100.00,
                      name:                 "Tiki Hut #{i}",
                      image_file_name:      "",
                      image_content_type:   "",
                      image_file_size:      nil,
                      image_updated_at:     nil,
                      gmaps:                nil,
                      lat:                  nil,
                      long:                 nil,
                      number_of_days:       nil,
                      host_id:              business_admin.id)
    end
  end

  def create_locations
    places = [
      'North America',
      'South America',
      'Europe',
      'Africa',
      'Asia',
      'Australia',
      'Antarctica'
    ]

    places.each do |place|
      Location.find_or_create_by!(continent: place)
    end
  end
end
