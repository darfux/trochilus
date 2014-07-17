json.array!(@donation_types) do |donation_type|
  json.extract! donation_type, :id, :name
  json.url donation_type_url(donation_type, format: :json)
end
