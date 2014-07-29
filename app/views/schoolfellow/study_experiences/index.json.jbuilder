json.array!(@schoolfellow_study_experiences) do |schoolfellow_study_experience|
  json.extract! schoolfellow_study_experience, :id, :schoolfellow_id, :major_id, :degree_id, :attendance_date, :graduated_date, :student_number
  json.url schoolfellow_study_experience_url(schoolfellow_study_experience, format: :json)
end
