xml.thesis_examination do |th|
  xml.date @thesis_examination.date
  xml.description @thesis_examination.description
  xml.title @thesis_examination.thesis.title
  xml.url @thesis_examination.thesis.url
  xml.student @thesis_examination.thesis.student
  xml.academic_degree @thesis_examination.thesis.academic_degree.name
  xml.instituition @thesis_examination.thesis.institution.name
  xml.teacher @thesis_examination.teacher.name
end
