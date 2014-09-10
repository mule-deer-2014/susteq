require 'faker'

FactoryGirl.define do
  factory :employee do
    provider_id {FactoryGirl.create(:provider).id}
    name {Faker::Name.name}
    email {Faker::Internet.email}
    phone_number {Faker::Number.number(10)}

    trait :with_password do
      password "1234567"
    end
  end
end
