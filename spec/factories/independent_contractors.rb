FactoryGirl.define do
  factory :team_lead do
  end

  factory :agent do
    team_lead
  end

  factory :distributor do
    after(:build) do |distributor|
      # Random ordering only for postgresql
      distributor.distributorships << Distributorship.limit(rand(1..Distributor.count)).order('RANDOM()')
    end
  end

  factory :office_manager do
  end

  factory :office_admin do
  end

  factory :recruiter do
  end

  factory :independent_contractor do
    sequence(:agent_number) {|n| n }
    business_num { Faker::PhoneNumber.cell_phone }
    city { Faker::Address.city }
    country { Faker::Address.country }
    card_number { Faker::Business.credit_card_number }
    ic_code { Faker::Number.number(10).to_s }
    payment_method { Faker::Business.credit_card_type }
    phone_home { Faker::PhoneNumber.phone_number }
    phone_mobile { Faker::PhoneNumber.cell_phone }
    postal_zip { Faker::Address.zip }
    state_province { Faker::Address.state }
    street_name { Faker::Address.street_name }
    street_number { Faker::Address.building_number }
    unit_num { Faker::Address.secondary_address }
    preinspector [true, false].sample
    lead_booker [true, false].sample
    ic_signed [true, false].sample
    office

    IndependentContractor::USER_SUBTYPES.each do |ic_subtype|
      factory "independent_contractor_#{ic_subtype}".to_sym do
        after(:build) do |ic, evaluator|
          if ic_subtype == :agent
            tl = IndependentContractor.where(office: ic.office).where('team_lead_id IS NOT NULL').sample
            ic.subtype = FactoryGirl.create(
              ic_subtype,
              team_lead: (tl && tl.subtype) || FactoryGirl.create('independent_contractor_team_lead').subtype
            )
          else
            ic.subtype = FactoryGirl.create(ic_subtype)
          end
        end

        after(:create) do |ic, evaluator|
          FactoryGirl.create(:user, email: "#{ic_subtype}#{ic.subtype.class.count + 1}@email.com", subtype: ic)
        end
      end
    end
  end
end
