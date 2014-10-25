json.array! @cs do |c|
  json.name c.name
  json.url url_for(c)
end 
