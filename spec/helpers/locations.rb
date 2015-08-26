module LocationsHelper
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
      Location.create!(continent: place)
    end
  end
end