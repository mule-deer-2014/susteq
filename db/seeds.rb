require 'faker'

def generate_random_lat_long(lat_min, lat_max, long_min, long_max)
  lat_range = lat_max - lat_min
  long_range = long_max - long_min
  lat = lat_min + (lat_range * rand)
  long = long_min + (long_range * rand)
  return [lat, long]
end

hub_number = 1

5.times do
  Admin.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456"
  )
end

3.times do
  Provider.create(
    name: Faker::Company.name,
    address: Faker::Address.street_address,
    country: Faker::Address.country,
    duns_number: rand(100000000..999999999).to_s
  )
end

Provider.all.each do |provider|
  4.times do
    provider.employees.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "123456"
    )
  end

  rand(1..3).times do
    # the latitude and longitude ranges used in generate_random_lat_long here and below are coordinates for the area surrounding Nairobi, Kenya, i.e. arbitrary for seed data purposes.
    lat_long = generate_random_lat_long(-1.377018, -1.219302, 36.636440, 36.959850)
    pump = provider.pumps.create(name: Faker::Name.name, location_id: hub_number, latitude: lat_long[0], longitude: lat_long[1])
    5.times do
      pump.transactions.create(
        transaction_time: DateTime.now,
        transaction_code: 1,
        location_id: hub_number,
        amount: rand(1..15)
      )
    end
    hub_number += 1
  end


  rand(1..3).times do
    lat_long = generate_random_lat_long(-1.377018, -1.219302, 36.636440, 36.959850)
    kiosk = provider.kiosks.create(name: Faker::Name.name, location_id: hub_number, latitude: lat_long[0], longitude: lat_long[1])
    5.times do
      kiosk.transactions.create(
        transaction_time: DateTime.now,
        transaction_code: 22,
        location_id: hub_number,
        amount: rand(8..20) * 10
      )
    end
    hub_number += 1
  end
end
