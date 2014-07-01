puts 'seeding folders...'

folders = [
    {
      name: "PED",
      subject_id: 1,
      folder_id: 0
    },
    {
      name: "PL",
      subject_id: 2,
      folder_id: 0
    },
    {
      name: "PL",
      subject_id: 2,
      folder_id: 3
    },
    {
      name: "PED2",
      subject_id: 1,
      folder_id: 1
    },
]

folders.each do |folder|
  Folder.where(folder).first_or_create!
end
