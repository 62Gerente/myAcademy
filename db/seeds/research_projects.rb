puts 'seeding research projects...'

research_projects = [
    {
      b_date: DateTime.new(2001),
      e_date: DateTime.new(2003),
      description: "Anotação Estrutural de Documentos e sua Semântica",
      teacher_id:1,
      name: "Anotação Estrutural de Documentos e sua Semântica",
      url: "http://doomz.com"
    },
    {
     b_date: DateTime.new(2001),
      e_date: DateTime.new(2003),
      description: "Anotação Estrutural de Documentos e sua Semântica",
      teacher_id:1,
      name: "Anotação Estrutural de Documentos e sua Semântica",
      url: "http://doomz.com"
    }
]

research_projects.each do |project|
  ResearchProject.where(project).first_or_create!
end
