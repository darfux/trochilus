json.array!(@schoolfellow_teach_experiences) do |schoolfellow_teach_experience|
  json.extract! schoolfellow_teach_experience, :id, :schoolfellow_id, :teacher_title_id, :teach_start, :teach_end, :teacher_id
  json.url schoolfellow_teach_experience_url(schoolfellow_teach_experience, format: :json)
end
