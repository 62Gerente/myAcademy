json.array!(@examinations) do |examination|
  json.extract! examination, :id, :date, :description, :thesis_id, :teacher_id
  json.url examination_url(examination, format: :json)
end
