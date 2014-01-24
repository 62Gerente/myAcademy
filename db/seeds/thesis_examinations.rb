require 'seeder/thesis_examinations'

puts "seeding thesis examinations..."
seeder = Seeder::ThesisExaminations.new
seeder.seed
