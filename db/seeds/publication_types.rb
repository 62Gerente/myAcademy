puts 'seeding publication types...'

types = [
    {name: "inbook"},
    {name: "inproceeding"},
    {name: "article"},
    {name: "misc"},
    {name: "proceeding"},
    {name: "book"},
    {name: "phdthesis"},
    {name: "masterthesis"}
]

types.each do |type|
  PublicationType.where(type).first_or_create!
end
