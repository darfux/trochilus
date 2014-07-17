json.array!(@donation_records) do |donation_record|
  json.extract! donation_record, :id, :customer_id, :project_id, :creator_id, :plan_fund_id, :donation_type_id
  json.url donation_record_url(donation_record, format: :json)
end
