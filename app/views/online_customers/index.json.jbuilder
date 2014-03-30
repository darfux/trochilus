json.array!(@online_customers) do |online_customer|
  json.extract! online_customer, :id, :customer_id
  json.url online_customer_url(online_customer, format: :json)
end
