json.data do
  json.array!(@customers) do |customer|
    json.extract! customer, :id, :full_name, :address, :phone_number
    json.url customer_url(customer, format: :json)
  end
end
