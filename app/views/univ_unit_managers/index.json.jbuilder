json.array!(@univ_unit_managers) do |univ_unit_manager|
  json.extract! univ_unit_manager, :id, :name, :univ_unit_id
  json.url univ_unit_manager_url(univ_unit_manager, format: :json)
end
