FactoryGirl.define do
  factory :user, class: 'User' do
    email { Faker::Internet.email }
    uid { email }
    password 'password'
    password_confirmation { password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    provider "email"
  end
end
