json.array!(@courses) do |course|
  json.extract! course, :id, :name, :institution_id
  json.url course_url(course, format: :json)
end
