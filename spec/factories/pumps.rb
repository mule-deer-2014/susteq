require 'faker'

FactoryGirl.define do
  factory :pump do
    name {Faker::Lorem.word}
    location_id {Faker::Number.number(2)}
    provider {FactoryGirl.create(:provider)}
    latitude 50
    longitude 100
  end
end
