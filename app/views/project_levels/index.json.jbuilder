json.array!(@project_levels) do |project_level|
  json.extract! project_level, :id, :name
  json.url project_level_url(project_level, format: :json)
end
