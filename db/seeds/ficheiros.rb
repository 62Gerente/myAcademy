require "open-uri"
puts 'seeding files...'

files = [    {
      name: "ficheiro1",
      subject_id: 1,
      folder_id: 1,
      file:"https://www.dropbox.com/s/pxc9ix6i1gplmo8/caosguerrila2_3.jpg"
    },
    {
      name: "ficheiro2",
      subject_id: 1,
      folder_id: 1,
      file:"https://www.dropbox.com/s/pxc9ix6i1gplmo8/caosguerrila2_3.jpg"
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
