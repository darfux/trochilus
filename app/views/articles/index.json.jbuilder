json.array!(@articles) do |article|
  json.extract! article, :id, :title, :cotent, :time, :counter, :channel_id_id
  json.url article_url(article, format: :json)
end
