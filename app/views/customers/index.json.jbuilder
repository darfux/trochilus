json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :customer_type_id, :employee_id
  json.url customer_url(customer, format: :json)
end
