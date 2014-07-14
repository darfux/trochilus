json.array!(@usage_types) do |usage_type|
  json.extract! usage_type, :id, :name
  json.url usage_type_url(usage_type, format: :json)
end
