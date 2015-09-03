class Seed
  def self.start
    seed = Seed.new
    seed.generate_locations
    seed.generate_roles
    seed.generate_users
    seed.generate_listings
    seed.generate_reservations
  end

  def places
    ['North America',
     'South America',
     'Europe',
     'Africa',
     'Asia',
     'Australia',
     'Antarctica']
  end

  def listing_cost
    [100.00, 250.00, 199.50, 99.99, 125.59, 485.50, 299.00, 110.00, 109.01, 222.00, 175.75]
  end

  def listing_names_first
    ['Outstanding', 'Awesome', 'Ambiguous', 'Nondescript', 'Radiant', 'Secluded', 'Out-of-the-way',
     'Ramshackle', 'Splendid', 'Spacious', 'Quaint', 'Romantic', 'Remote', 'Isolated', 'Abandoned']
  end

  def listing_names_last
    ['Tent', 'Cabana', 'Hut', 'Igloo', 'Cottage', 'Barn', 'Hole', 'Hideout', 'Compound',
     'Oasis', 'Houseboat', 'Cabin', 'Cave', 'Grotto', 'Chateau', 'Missile-Silo']
  end

  def user_first_names
    ['Apple', 'Moonunit', 'Ginger', 'Osirus', 'Maximus', 'Door', 'Persnipity', 'Joony', 'Demmy',
     'Purple', 'Whisper', 'Cry', 'Love', 'Rosannadanna', 'Nog', 'Billy', 'Shimmy', 'Jon', 'Sparticus',
     'Penelope', 'Mork', 'Mindy', 'Nelson', 'Dude', 'Tool', 'Darth', 'Biff', 'Toodles', 'Disguy', 'Mud',
     'Tambourine', 'Lazarus', 'Domino', 'Arya']
  end

  def user_last_names
    ['Anderson', 'Smith', 'Georgianity', 'Galapinopus', 'Danger', 'Gnarl', 'Egg', 'MacNinnypoop',
     'Aladocious', 'Westerly', 'DarkDirk', 'Puffinstuff', 'Jones', 'Daring', 'Bond', 'TheGreek',
     'Cocopop', 'Star', 'Skywalker', 'Snow', 'Blitzkreig', 'Pitstop', 'Stark', 'Trump', 'Moneybags']
  end

  def role_types
    ['registered_user',
     'business_admin',
     'platform_admin']
  end

  def generate_locations
    places.each do |place|
      Location.find_or_create_by!(continent: place)
    end
  end

  def generate_roles
    role_types.each do |type|
      Role.find_or_create_by!(title: type)
    end
  end

  def generate_users
    registered_role = Role.find_by(title: "registered_user")
    business_role   = Role.find_by(title: "business_admin")
    platform_role   = Role.find_by(title: "platform_admin")

    15.times do |i|
      user = User.create(username: user_first_names[i], password: 'password')
      user.roles << registered_role
      puts "User: #{user.username} created!"
    end

    3.times do |i|
      name = user_first_names.sample
      platform_admin_user = User.create(username: "Super#{user_first_names[i]}", password: 'password')
      user_first_names.delete(name)
      platform_admin_user.roles << registered_role
      platform_admin_user.roles << business_role
      platform_admin_user.roles << platform_role
      puts "User: #{platform_admin_user.username} created!"
    end

  end

  def random_location_id
    (1..7).to_a.sample
  end

  def lats_longs
    {
      'North America' => [[48.541718,  -101.939431],[48.216504,  -121.777344]],
      'South America' => [[-37.589127, -60.605469], [-5.453227,  -80.468750]],
      'Europe' =>        [[57.884980,  -4.355469],  [56.358458,  14.628906]],
      'Africa' =>        [[-10.672656, 38.359375],  [34.151672,  -6.289062]],
      'Asia' =>          [[64.236300,  103.271580], [61.597319,  161.806736]],
      'Australia' =>     [[-27.754635, 136.686174], [-22.423040, 113.932693]],
      'Antarctica' =>    [[-73.382630, 168.142737], [-68.853235, 34.197426],   [-80.151325, 84.119300]]
    }
  end

  def generate_listings
    business_role   = Role.find_by(title: "business_admin")
    registered_role = Role.find_by(title: "registered_user")
    25.times do |i|
      business_admin = User.create(username: user_first_names[i] + user_last_names.sample, password: 'password')
      business_admin.roles << registered_role
      business_admin.roles << business_role
      business_admin.update!(host_id: business_admin.id)
      puts "User: #{business_admin.username} created!"
      location      = random_location_id
      continent     = Location.find(location).continent
      lat_long      = lats_longs[continent].sample
      listing_name  = "#{listing_names_first.sample} #{listing_names_last.sample}"
      listing_image = "#{listing_name.split(' ').last}-#{rand(1..2)}.jpg"

      Listing.create(location_id: location,
                     cost:        listing_cost.sample,
                     name:        listing_name,
                     image:       File.open("app/assets/images/#{listing_image}"),
                     gmaps:       true,
                     lat:         lat_long[0],
                     long:        lat_long[1],
                     host_id:     business_admin.id)
      puts "Listing: Listing with host #{business_admin.id} created!"
    end
  end

  def generate_reservations
    10.times do
      Reservation.find_or_create_by!(user_id:      User.first(10).sample.id,
                                     status:       ['Ordered', 'Paid', 'Completed'].sample,
                                     listing_id:   Listing.first(10).sample.id,
                                     start_date:   Date.today,
                                     end_date:     Date.today)
    end
  end
end

Seed.start
