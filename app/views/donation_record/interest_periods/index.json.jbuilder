json.array!(@donation_record_interest_periods) do |donation_record_interest_period|
  json.extract! donation_record_interest_period, :id, :rate, :start, :end, :comment, :donation_record_id
  json.url donation_record_interest_period_url(donation_record_interest_period, format: :json)
end
