FactoryGirl.define do
  factory :program do
    name 'MyString'
    description 'MyText'
    start_date '2015-06-28'
    end_date '2015-06-28'
    billing_type 1
    active false
  end
end
