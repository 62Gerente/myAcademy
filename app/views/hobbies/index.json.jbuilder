json.array!(@hobbies) do |hobby|
  json.extract! hobby, :id, :activity, :b_date, :e_date, :description, :teacher_id
  json.url hobby_url(hobby, format: :json)
end
