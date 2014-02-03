puts 'seeding academic information...'

academic_information = [
    {
      b_date: DateTime.new(2001),
      e_date: DateTime.new(2003),
      description: "Muito bom que foi",
      grade: 19,
      academic_degree_id: 2,
      course_id: 1,
      institution_id: 5 ,
      teacher_id:1,
    },
    {
      b_date: DateTime.new(2003),
      e_date: DateTime.new(2006),
      description: "Muito bom que foi 2",
      grade: 18,
      academic_degree_id: 1,
      course_id: 2,
      institution_id: 5 ,
      teacher_id:1,
    }
]

academic_information.each do |info|
  AcademicInformation.where(info).first_or_create!
end
