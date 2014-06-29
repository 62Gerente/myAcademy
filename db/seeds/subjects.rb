puts 'seeding subjects...'

subjects = [{
              name: "PED",
              academic_year: "2013/2014",
              description: "Processamento estruturado de documentos",
              course_id: 2,
              teacher_id: 1
            },
            {
              name: "PL",
              academic_year: "2013/2014",
              description: "Processamento de linguagens",
              course_id: 1,
              teacher_id: 1
            }
            ]

subjects.each do |subject|
  Subject.where(subject).first_or_create!
end
