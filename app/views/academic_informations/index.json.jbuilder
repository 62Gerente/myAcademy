json.array!(@academic_informations) do |academic_information|
  json.extract! academic_information, :id, :b_date, :e_date, :description, :grade, :academic_degree_id, :course_id, :institution_id, :teacher_id
  json.url academic_information_url(academic_information, format: :json)
end
