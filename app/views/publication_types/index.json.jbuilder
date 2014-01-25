json.array!(@publication_types) do |publication_type|
  json.extract! publication_type, :id, :name
  json.url publication_type_url(publication_type, format: :json)
end
