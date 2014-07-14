json.array!(@usage_records) do |usage_record|
  json.extract! usage_record, :id, :fund_id, :employee_id, :project_id, :exec_unit_id, :exec_manager_id, :benefit_unit_id, :benefit_manager_id, :usage_type_id
  json.url usage_record_url(usage_record, format: :json)
end
