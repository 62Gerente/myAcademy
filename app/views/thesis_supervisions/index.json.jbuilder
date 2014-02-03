json.array!(@thesis_supervisions) do |thesis_supervision|
  json.extract! thesis_supervision, :id, :b_date, :e_date, :description, :teacher_id, :thesis_id
  json.url thesis_supervision_url(thesis_supervision, format: :json)
end
