json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :name, :status, :phone, :birthday, :url, :bio, :registed, :institution_id, :email, :encrypted_password
  json.url teacher_url(teacher, format: :json)
end
