FactoryGirl.define do
  factory :distributorship do
    name { Faker::Lorem.word }

    factory :distributorship_with_ics do
      transient do
        office_count 5
      end

      after(:create) do |distributorship, evaluator|
        evaluator.office_count.times do
          create(:offices_with_ics, distributorship: distributorship)
        end
      end
    end
  end
end
