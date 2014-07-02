require "open-uri"
puts 'seeding files...'

files = [    {
      name: "ficheiro1",
      subject_id: 1,
      folder_id: 1,
      file:"http://www3.di.uminho.pt/~jcr/foto-jcr-xata2006.jpg"
    },
    {
      name: "ficheiro2",
      subject_id: 1,
      folder_id: 4,
      file:"http://www3.di.uminho.pt/~jcr/AULAS/engweb2011/fichas2011/ficha1/Local.rdf"
    }
]

files.each do |file|
  Ficheiro.first_or_initialize.tap do |f|
    f.name = file[:name]
    f.subject_id = file[:subject_id]
    f.folder_id = file[:folder_id]
    f.file = open(file[:file])
    f.save!
  end
end
