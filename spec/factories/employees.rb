FactoryGirl.define do
  factory :employee do
    city { Faker::Address.city }
    country { Faker::Address.country }
    phone_home { Faker::PhoneNumber.phone_number }
    postal_zip { Faker::Address.postcode }
    state_province { Faker::Address.state }
    street_name { Faker::Address.street_name }
    street_number { Faker::Address.building_number }

    after(:create) do |emp, evaluator|
      FactoryGirl.create(:user, email: "employee#{Employee.count + 1}@email.com", subtype: emp)
    end
  end
end
