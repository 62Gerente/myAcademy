json.array!(@theses) do |thesis|
  json.extract! thesis, :id, :title, :url, :student, :academic_degree_id, :institution_id
  json.url thesis_url(thesis, format: :json)
end
