class Seed
  def self.start
    seed = Seed.new
    seed.generate_listings
    seed.generate_roles
    seed.generate_users
    seed.generate_reservations
    seed.generate_locations
  end

  places = ['North America',
            'South America',
            'Europe',
            'Africa',
            'Asia',
            'Australia',
            'Antarctica']


  role_types = ['registered_user',
                'business_admin',
                'platform_admin']

  def generate_locations
    places.each do |place|
      Location.create!(continent: place)
    end
  end

  def generate_roles
    role_types.each do |type|
      Role.create!(title: type)
    end
  end

  def generate_users
    25.times do |i|
      user = User.create!(username: "registered_user_#{i}", password_digest: 'password')
      user.update!(host_id: user.id)
      puts "User: #{user.username} created!"
    end

    5.times do |i|
      platform_admin = User.create!(username: "platform_admin_#{i}", password_digest: 'password')
      puts "User: #{platform_admin.username} created!"
    end

  end

  def location_ids
    (1..7).to_a.sample
  end


  def generate_listings
    25.times do |i|
      business_admin = User.create!(username: "business_admin_#{i}", password_digest: 'password')
      business_admin.update!(host_id: business_admin.id)
      puts "User: #{business_admin.username} created!"

      listing = Listing.create!(location_id:          location_ids,
                                cost:                 100.00,
                                name:                 ,
                                image_file_name:      ,
                                image_content_type:   ,
                                image_file_size:      ,
                                image_updated_at:     ,
                                gmaps:                ,
                                lat:                  ,
                                long:                 ,
                                number_of_guests:     ,
                                host_id:              business_admin.id)
      puts "Listing: Listing with host #{business_admin.id} created!"
    end
  end

  def generate_reservations

  end

end

Seed.start
