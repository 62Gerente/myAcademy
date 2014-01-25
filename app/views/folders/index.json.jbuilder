json.array!(@folders) do |folder|
  json.extract! folder, :id, :name, :folder_id, :subject_id
  json.url folder_url(folder, format: :json)
end
