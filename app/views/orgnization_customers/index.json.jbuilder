json.array!(@orgnization_customers) do |orgnization_customer|
  json.extract! orgnization_customer, :id, :customer_id
  json.url orgnization_customer_url(orgnization_customer, format: :json)
end
