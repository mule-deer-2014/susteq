require 'faker'

def generate_date_from_last_six_months
  year = 2014
  month = rand(6)+4
  day = rand(30)+1     #Pour one out for n/31/2014; no pressing reason to add in the logic.
  DateTime.new(year, month, day)
end

def generate_random_lat_long(lat_min, lat_max, long_min, long_max)
  lat_range = lat_max - lat_min
  long_range = long_max - long_min
  lat = lat_min + (lat_range * rand)
  long = long_min + (long_range * rand)
  return [lat, long]
end

#For development purposes so team can easily login
  Admin.create!(
    name: "susteq",
    email: "susteq@dbc.com",
    password: "123456"
  )

  Provider.create!(
    name: "ABC Water Service Provider",
    address: "Nairobi",
    country: "Kenya",
    duns_number: "121312312"
  ).employees.create!(
    name: "John Doe",
    email: "susteq_employee@dbc.com",
    password: "123456"
  )

hub_number = 1

5.times do
  Admin.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456"
  )
end

3.times do
  Provider.create!(
    name: Faker::Company.name,
    address: Faker::Address.street_address,
    country: Faker::Address.country,
    duns_number: rand(100000000..999999999).to_s
  )
end

hub_number = 1
Provider.all.each do |provider|
  4.times do
    provider.employees.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "123456"
    )
  end


  rand(1..3).times do
    # the latitude and longitude ranges used in generate_random_lat_long here and below are coordinates for the area surrounding Nairobi, Kenya, i.e. arbitrary for seed data purposes.
    lat_long = generate_random_lat_long(-1.377018, -1.219302, 36.636440, 36.959850)
    pump = provider.pumps.create!(name: Faker::Name.name, location_id: hub_number, latitude: lat_long[0], longitude: lat_long[1], status_code:[-1,0,1].sample)
    5.times do
      pump.transactions.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 1,
        location_id: hub_number,
        amount: rand(1..15)
      )
    end
    hub_number += 1
  end

  rand(1..3).times do
    #SEE COMMENT ABOVE ABOUT LAT_LONG COORDINATES
    lat_long = generate_random_lat_long(-1.377018, -1.219302, 36.636440, 36.959850)
    kiosk = provider.kiosks.create!(name: Faker::Name.name, location_id: hub_number, latitude: lat_long[0], longitude: lat_long[1], status_code:[-1,0,1].sample)
    5.times do
      kiosk.transactions.create!(
        transaction_time: generate_date_from_last_six_months,
        transaction_code: 22,
        location_id: hub_number,
        amount: rand(8..20) * 10
      )
    end
    hub_number += 1
  end
end


  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 20,
    location_id: 1,
    amount: 2
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 20,
    location_id: 1,
    amount: 2
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 1,
    amount: 1,
    starting_credits: 5,
    ending_credits: 10
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 20,
    location_id: 2,
    amount: 3
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 20,
    location_id: 2,
    amount: 4
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 2,
    amount: 3,
    starting_credits: 5,
    ending_credits: 10
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 2,
    amount: 4,
    starting_credits: 10,
    ending_credits: 5
  )

  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 1,
    location_id: 1,
    amount: 2
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 1,
    location_id: 1,
    amount: 2
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 1,
    amount: 1,
    starting_credits: 5,
    ending_credits: 10
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 1,
    location_id: 2,
    amount: 3
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 1,
    location_id: 2,
    amount: 4
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 2,
    amount: 3,
    starting_credits: 5,
    ending_credits: 10
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 2,
    amount: 4,
    starting_credits: 10,
    ending_credits: 5
  )
  Transaction.create!(
    transaction_time: Date.new(2014,1,1),
    transaction_code: 41,
    location_id: 1,
    amount: 2
  )
  Transaction.create!(
    transaction_time: Date.new(2014,2,2),
    transaction_code: 41,
    location_id: 1,
    amount: 2
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 1,
    amount: 1,
    starting_credits: 5,
    ending_credits: 10
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 41,
    location_id: 2,
    amount: 3
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 41,
    location_id: 2,
    amount: 4
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 2,
    amount: 3,
    starting_credits: 5,
    ending_credits: 10
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 2,
    amount: 4,
    starting_credits: 10,
    ending_credits: 5
  )

  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 1,
    location_id: 1,
    amount: 2
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 1,
    location_id: 1,
    amount: 2
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 1,
    amount: 1,
    starting_credits: 5,
    ending_credits: 10
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 1,
    location_id: 2,
    amount: 3
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 1,
    location_id: 2,
    amount: 4
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 2,
    amount: 3,
    starting_credits: 5,
    ending_credits: 10
  )
  Transaction.create!(
    transaction_time: generate_date_from_last_six_months,
    transaction_code: 23,
    location_id: 2,
    amount: 4,
    starting_credits: 10,
    ending_credits: 5
  )

200.times do
  transaction_code = [1, 20, 21, 22, 23, 39, 41].sample
  location_id = (1..10).to_a.sample

  transaction_code == 39 ?
    Transaction.create!(
      transaction_time: generate_date_from_last_six_months,
      transaction_code: transaction_code,
      location_id: location_id,
      amount: [109, 111, 132, 133].sample,
      starting_credits: (0..20).to_a.sample,
      ending_credits: (0..20).to_a.sample
    ) :
    Transaction.create!(
      transaction_time: generate_date_from_last_six_months,
      transaction_code: transaction_code,
      location_id: location_id,
      amount: (50..200).to_a.sample
    )
end
