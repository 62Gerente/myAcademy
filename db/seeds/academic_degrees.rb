puts 'seeding academic degrees...'

academic_degrees = [
    {name: "phd"},
    {name: "msc"}
]

academic_degrees.each do |degree|
  AcademicDegree.where(degree).first_or_create!
end
