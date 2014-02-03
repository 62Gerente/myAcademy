require "seeder/publications.rb"

puts "seeding publications..."
seeder = Seeder::Publications.new
seeder.seed
