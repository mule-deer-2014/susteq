require 'faker'

FactoryGirl.define do
  factory :admin do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    type { "admin" }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
