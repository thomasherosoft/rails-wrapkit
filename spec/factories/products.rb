FactoryGirl.define do
  factory :product do
    name "MyString"
    description "MyText"
    duration 1
    allow_sales false
    product_type nil
    product_sub_type nil
    status false
  end
end
