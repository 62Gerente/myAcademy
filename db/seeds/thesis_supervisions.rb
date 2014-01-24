require 'seeder/thesis_supervisions'

puts "seeding thesis supervisions..."
seeder = Seeder::ThesisSupervisions.new
seeder.seed
