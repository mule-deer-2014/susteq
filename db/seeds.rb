5.times do
  Admin.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    #create BCrypt password
  )
end

3.times do
  Provider.create(
    name: Faker::Company.name,
    address: Faker::Address.street_address
    country: Faker::Address.country
    #duns_number: (x..y).sample
  )
end

Provider.all.each do |provider|
  4.times do
    provider.employees.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      #create BCrypt password
    )
  end
end
