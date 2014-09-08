require 'faker'

FactoryGirl.define do
  factory :kiosk do
    name {Faker::Lorem.word}
    location_id {Faker::Number.number(2)}
    provider {FactoryGirl.create(:provider)}
  end
end
