json.array!(@editors) do |editor|
  json.extract! editor, :id, :name, :publication_id
  json.url editor_url(editor, format: :json)
end
