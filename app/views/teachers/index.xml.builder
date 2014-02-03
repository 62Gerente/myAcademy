xml.instruct!
xml.teachers do
  @teachers.each do |teacher|
    xml.teacher do
      xml.name teacher.name
      xml.bio teacher.bio
      xml.status teacher.status
      xml.phone teacher.phone
      xml.birthday teacher.birthday
      xml.url teacher.url
      xml.registed teacher.registed
      xml.institution teacher.institution.name
      xml.email teacher.email
    end
  end
end
