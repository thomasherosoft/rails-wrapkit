FactoryGirl.define do
  factory :office do
    name { Faker::Lorem.word }
    distributorship

    factory :offices_with_ics do
      transient do
        ic_count 5
      end

      after(:create) do |office, evaluator|
        evaluator.ic_count.times do
          ([:team_lead] + IndependentContractor::USER_SUBTYPES).uniq.each do |ic_subtype|
            FactoryGirl.create(
              "independent_contractor_#{ic_subtype}".to_sym,
              office: office
            )
          end
        end
      end
    end
  end
end
