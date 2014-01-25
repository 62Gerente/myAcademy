json.array!(@activities) do |activity|
  json.extract! activity, :id, :name, :url, :b_date, :e_date, :description, :teacher_id, :activity_type, :references
  json.url activity_url(activity, format: :json)
end
