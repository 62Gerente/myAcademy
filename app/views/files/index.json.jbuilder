json.array!(@files) do |file|
  json.extract! file, :id, :name, :folder_id, :subject_id
  json.url file_url(file, format: :json)
end
