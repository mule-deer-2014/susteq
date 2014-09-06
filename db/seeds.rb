hub_number = 0

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
    duns_number: (100000000..999999999).sample.to_s
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

  (1..3).sample.times do
    pump = provider.pumps.create(location_id: hub_number)
    5.times do
      pump.transactions.create(
        transaction_time: Datetime.now,
        transaction_type: 1,
        location_id: hub_number,
        amount: (1..15).sample
      )
      hub_number += 1
    end
  end

  (1..3).sample.times do
    kiosk = provider.kiosks.create(location_id: hub_number)
    5.times do
      kiosk.transactions.create(
        transaction_time: Datetime.now,
        transaction_type: 22,
        location_id: hub_number,
        amount: (8..20).sample * 10
      )
    end
    hub_number += 1
  end
end
