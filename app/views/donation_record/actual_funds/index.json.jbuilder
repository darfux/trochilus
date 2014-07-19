json.array!(@donation_record_actual_funds) do |donation_record_actual_fund|
  json.extract! donation_record_actual_fund, :id
  json.url donation_record_actual_fund_url(donation_record_actual_fund, format: :json)
end
