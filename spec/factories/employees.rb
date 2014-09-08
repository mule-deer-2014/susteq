require 'faker'

FactoryGirl.define do
  factory :employee do
    provider_id 1
    name {Faker::Name.name}
    email {Faker::Internet.email}
    phone_number {Faker::PhoneNumber.phone_number}
    password "1234567"
  end
end
