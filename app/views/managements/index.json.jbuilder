json.array!(@managements) do |management|
  json.extract! management, :id, :b_date, :e_date, :description, :teacher_id, :role_id, :entity_id
  json.url management_url(management, format: :json)
end
