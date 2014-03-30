json.array!(@project_states) do |project_state|
  json.extract! project_state, :id, :name
  json.url project_state_url(project_state, format: :json)
end
