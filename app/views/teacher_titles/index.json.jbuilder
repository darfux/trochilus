json.array!(@teacher_titles) do |teacher_title|
  json.extract! teacher_title, :id, :name
  json.url teacher_title_url(teacher_title, format: :json)
end
