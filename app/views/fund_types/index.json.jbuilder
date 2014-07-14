json.array!(@fund_types) do |fund_type|
  json.extract! fund_type, :id, :name
  json.url fund_type_url(fund_type, format: :json)
end
