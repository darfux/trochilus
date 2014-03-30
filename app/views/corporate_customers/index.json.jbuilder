json.array!(@corporate_customers) do |corporate_customer|
  json.extract! corporate_customer, :id, :customer_id
  json.url corporate_customer_url(corporate_customer, format: :json)
end
