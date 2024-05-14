FactoryBot.define do
  # Market Factory
  factory :market do
    name { Faker::Company.name }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    county { Faker::Address.community }
    state { Faker::Address.state }
    zip { Faker::Address.zip_code }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
  end

  # Vendor Factory
  factory :vendor do
    name { Faker::Name.first_name }
    description { Faker::Lorem.paragraph }
    contact_name { Faker::Company.name }
    contact_phone { Faker::PhoneNumber.phone_number }
    credit_accepted { Faker::Boolean.boolean }
  end
end