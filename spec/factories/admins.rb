# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :admin do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password "123456"
  end
end


