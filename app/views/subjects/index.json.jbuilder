json.array!(@subjects) do |subject|
  json.extract! subject, :id, :name, :academic_year, :description, :course_id, :teacher_id
  json.url subject_url(subject, format: :json)
end
