json.array!(@item_donation_records) do |item_donation_record|
  json.extract! item_donation_record, :id, :customer_id, :project_id, :creator_id
  json.url item_donation_record_url(item_donation_record, format: :json)
end
