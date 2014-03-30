json.array!(@individual_customers) do |individual_customer|
  json.extract! individual_customer, :id, :customer_id
  json.url individual_customer_url(individual_customer, format: :json)
end
