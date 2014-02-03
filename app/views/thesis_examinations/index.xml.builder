xml.instruct!
xml.thesis_examinations do
  @thesis_examinations.each do |th|
    xml.thesis_examinations do
      xml.date th.date
      xml.description th.description
      xml.title th.thesis.title
      xml.url th.thesis.url
      xml.student th.thesis.student
      xml.academic_degree th.thesis.academic_degree.name
      xml.instituition th.thesis.institution.name
      xml.teacher th.teacher.name
    end
  end
end
