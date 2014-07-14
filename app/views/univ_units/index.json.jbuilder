json.array!(@univ_units) do |univ_unit|
  json.extract! univ_unit, :id, :name
  json.url univ_unit_url(univ_unit, format: :json)
end
