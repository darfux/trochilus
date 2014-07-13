json.array!(@contact_records) do |contact_record|
  json.extract! contact_record, :id, :customer_id, :employee_id, :time, :description
  json.url contact_record_url(contact_record, format: :json)
end
