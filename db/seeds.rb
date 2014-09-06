require 'faker'

hub_number = 1

5.times do
  Admin.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password_hash: BCrypt::Password.create("1234")
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
      password_hash: BCrypt::Password.create("1234")
    )
  end

  rand(1..3).times do
    pump = provider.pumps.create(location_id: hub_number)
    5.times do
      pump.transactions.create(
        transaction_time: DateTime.now,
        transaction_code: 1,
        location_id: hub_number,
        amount: rand(1..15)
      )
      hub_number += 1
    end
  end

  rand(1..3).times do
    kiosk = provider.kiosks.create(location_id: hub_number)
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
