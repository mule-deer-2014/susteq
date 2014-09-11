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

Provider.all.each do |provider|
  4.times do
    provider.employees.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "123456"
    )
  end
end

#   rand(1..3).times do
#     # the latitude and longitude ranges used in generate_random_lat_long here and below are coordinates for the area surrounding Nairobi, Kenya, i.e. arbitrary for seed data purposes.
#     lat_long = generate_random_lat_long(-1.377018, -1.219302, 36.636440, 36.959850)
#     pump = provider.pumps.create!(name: Faker::Name.name, location_id: hub_number, latitude: lat_long[0], longitude: lat_long[1], status_code:[-1,0,1].sample)
#     5.times do
#       pump.transactions.create!(
#         transaction_time: generate_date_from_last_six_months,
#         transaction_code: 1,
#         location_id: hub_number,
#         amount: rand(1..15)
#       )
#     end
#     hub_number += 1
#   end


#   rand(1..3).times do
#     #SEE COMMENT ABOVE ABOUT LAT_LONG COORDINATES
#     lat_long = generate_random_lat_long(-1.377018, -1.219302, 36.636440, 36.959850)
#     kiosk = provider.kiosks.create!(name: Faker::Name.name, location_id: hub_number, latitude: lat_long[0], longitude: lat_long[1], status_code:[-1,0,1].sample)
#     5.times do
#       kiosk.transactions.create!(
#         transaction_time: generate_date_from_last_six_months,
#         transaction_code: 22,
#         location_id: hub_number,
#         amount: rand(8..20) * 10
#       )
#     end
#     hub_number += 1
#   end
# end

require 'csv'
file = "db/data_dump.csv"

# # headers = [id, transaction_time, date,time, location_id, lattitude, longitude,rfid_id, starting_credits, ending_credits, transaction_type, amount, error_code]

# kiosks = []
# 15.times do
#   lat_long = generate_random_lat_long(-1.377018, -1.219302, 36.636440, 36.959850)
#   kiosks << Provider.all.sample.kiosks.create!(name: Faker::Name.name, location_id: hub_number, latitude: lat_long[0], longitude: lat_long[1], status_code:[-1,0,1].sample)
# end

CSV.foreach(file) do |csv_row|
  p "transaction (Line 107)"
  transaction = Transaction.create(transaction_time:Time.at(csv_row[1].to_i),location_id:csv_row[4].to_i, latitude:csv_row[5], longitude:csv_row[6], rfid_id: csv_row[7], starting_credits:csv_row[8],ending_credits:csv_row[9], transaction_code:csv_row[10].to_i, amount:csv_row[11].to_i, error_code:csv_row[12])
  if [20,21].include?(transaction.transaction_code) && Kiosk.find_by_location_id(transaction.location_id)
    p "110"
    kiosk = Kiosk.find_by_location_id(transaction.location_id)
    kiosk.transactions << transaction
  elsif [20,21].include?(transaction.transaction_code)
    provider = Provider.all.sample
    lat_long = generate_random_lat_long(-1.377018, -1.219302, 36.636440, 36.959850)
    kiosk = provider.kiosks.create!(name: Faker::Name.name, location_id: hub_number, latitude: lat_long[0], longitude: lat_long[1], status_code:[-1,0,1].sample)
    5.times do
      kiosk.transactions.create!(
        transaction_time: DateTime.new(2014,2,1),
        transaction_code: 21,
        location_id: hub_number,
        amount: 2
      )
      kiosk.transactions.create!(
        transaction_time: DateTime.new(2014,3,1),
        transaction_code: 21,
        location_id: hub_number,
        amount: 3
      )
      kiosk.transactions.create!(
        transaction_time: DateTime.new(2014,4,1),
        transaction_code: 20,
        location_id: hub_number,
        amount: 4
      )
    end
    hub_number += 1
  end
end

      Transaction.create!(
        transaction_time: DateTime.new(2014,3,1),
        transaction_code: 21,
        location_id: 1,
        amount: 1
      )
      Transaction.create!(
        transaction_time: DateTime.new(2014,4,1),
        transaction_code: 20,
        location_id: 1,
        amount: 2
      )
      Transaction.create!(
        transaction_time: DateTime.new(2014,4,1),
        transaction_code: 20,
        location_id: 1,
        amount: 2
      )
      Transaction.create!(
        transaction_time: DateTime.new(2014,3,1),
        transaction_code: 21,
        location_id: 2,
        amount: 3
      )
      Transaction.create!(
        transaction_time: DateTime.new(2014,4,1),
        transaction_code: 20,
        location_id: 2,
        amount: 4
      )
