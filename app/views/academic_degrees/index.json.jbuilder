json.array!(@academic_degrees) do |academic_degree|
  json.extract! academic_degree, :id, :name
  json.url academic_degree_url(academic_degree, format: :json)
end
