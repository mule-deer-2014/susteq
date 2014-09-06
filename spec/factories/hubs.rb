require 'faker'

FactoryGirl.define do
  factory :hub do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
