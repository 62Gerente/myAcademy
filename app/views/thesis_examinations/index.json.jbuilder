json.array!(@thesis_examinations) do |thesis_examination|
  json.extract! thesis_examination, :id, :date, :description, :thesis_id, :teacher_id
  json.url thesis_examination_url(thesis_examination, format: :json)
end
