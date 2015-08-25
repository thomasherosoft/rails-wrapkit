json.status status
json.message message
json.extract! @customer, :id, :created_at, :updated_at
