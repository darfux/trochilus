json.array!(@project_necessary_dates) do |project_necessary_date|
  json.extract! project_necessary_date, :id, :date, :comment, :project_id
  json.url project_necessary_date_url(project_necessary_date, format: :json)
end
