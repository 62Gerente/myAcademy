require "open-uri"
puts "seeding teachers..."

teachers = [
  {
    name: "José Carlos Ramalho",
    username: "jcr",
    status: "Prof. Auxiliar",
    phone: "999999999",
    email: "jcr@di.uminho.pt",
    birthday: Date.today,
    url: "http://www3.di.uminho.pt/~jcr/",
    bio: "José Carlos Ramalho graduated in 1991 as a Systems and Informatics Engineer. During his graduation he has worked as a freelancer software developer and as a network technician for Apple. During this time he also taught several courses about computer programming for several public institutions.",
    registed: true,
    password: "jcrjcrjcr",
    institution_id: 5,
    last_sign_in_at: DateTime.now,
    photo: "http://www3.di.uminho.pt/~jcr/jcr@keep.jpg"
  }
]


teachers.each do |teacher|
  Teacher.where(email: teacher[:email]).first_or_initialize.tap do |t|
    t.name = teacher[:name]
    t.username = teacher[:username]
    t.status = teacher[:status]
    t.phone = teacher[:phone]
    t.birthday = teacher[:birthday]
    t.url = teacher[:url]
    t.bio = teacher[:bio]
    t.registed = teacher[:registed]
    t.password = teacher[:password]
    t.institution_id = teacher[:institution_id]
    t.photo = open(teacher[:photo])
    t.save!
  end
end
