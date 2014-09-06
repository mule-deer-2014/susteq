# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :admin do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password_digest Faker::Internet.password(10, 20)
  end
end


