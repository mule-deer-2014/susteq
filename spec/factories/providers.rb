require 'faker'

FactoryGirl.define do
  factory :provider do
    name {Faker::Name.name}
    address {Faker::Address.street_address}
    country {Faker::Address.country}
    duns_number {Faker::Lorem.word}
  end
end
