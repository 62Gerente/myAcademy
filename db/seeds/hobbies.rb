puts 'seeding hobbies...'
 
hobbies = [
    {
        activity: "Geocaching",
        description: "http://www.geocaching.com/profile/?guid=544b022f-e962-4d98-a1d0-5aa67eaf23ef",
        teacher_id: 1
        },
    {
        activity: "Squash",
        teacher_id: 1
        },
        {
                activity: "Saxofonista",
        teacher_id: 1
        },
        {
                activity: "Atletismo",
        teacher_id: 1
     }
]
 
hobbies.each do |hobby|
  Hobby.where(hobby).first_or_create!
end
