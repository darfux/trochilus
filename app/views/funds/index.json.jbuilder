json.array!(@funds) do |fund|
  json.extract! fund, :id, :amount, :time, :fund_type_id, :comment, :currency_id, :origin_amount
  json.url fund_url(fund, format: :json)
end
