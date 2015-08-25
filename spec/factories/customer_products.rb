FactoryGirl.define do
  factory :customer_product do
    customer nil
    application nil
    status 1
    program nil
    product nil
    price 1.5
    hst false
    free false
    serial_number "MyString"
    model_number "MyString"
    type 1
    coil_serial_number "MyString"
    coil_model_number "MyString"
    purchase_date "2015-06-28"
    funded false
  end
end
