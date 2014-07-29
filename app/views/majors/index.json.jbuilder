json.array!(@majors) do |major|
  json.extract! major, :id, :name, :univ_unit_id
  json.url major_url(major, format: :json)
end
