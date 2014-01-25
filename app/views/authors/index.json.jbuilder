json.array!(@authors) do |author|
  json.extract! author, :id, :name, :publication_id, :teacher_id
  json.url author_url(author, format: :json)
end
