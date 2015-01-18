json.array!(@items) do |item|
  json.extract! item, :id, :name, :name_abbrpy, :amount, :price, :comment, :item_donation_record_id, :item_category_id
  json.url item_url(item, format: :json)
end
