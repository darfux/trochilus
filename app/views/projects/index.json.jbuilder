json.array!(@projects) do |project|
  json.extract! project, :id, :name, :serialnum, :create_date, :funder, :brief, :gross, :balance, :endowment, :project_level_id, :project_state_id
  json.url project_url(project, format: :json)
end
