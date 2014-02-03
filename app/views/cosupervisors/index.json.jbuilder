json.array!(@co_supervisors) do |co_supervisor|
  json.extract! co_supervisor, :id, :name, :institution, :teacher_id, :thesis_supervision_id
  json.url co_supervisor_url(co_supervisor, format: :json)
end
