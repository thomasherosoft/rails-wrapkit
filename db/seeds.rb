require 'ostruct'
require 'factory_girl'
require 'faker'
Dir['./spec/factories/*.rb'].each { |file| require file } if Rails.env.production?

if !User.any?
  3.times do
    FactoryGirl.create(:distributorship_with_ics)
  end

  10.times do
    FactoryGirl.create(:employee)
  end
end
