json.array!(@undetermined_funds) do |undetermined_fund|
  json.extract! undetermined_fund, :id
  json.url undetermined_fund_url(undetermined_fund, format: :json)
end
