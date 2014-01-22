require 'parsers/thesis_examination'
puts "seeding thesis examinations..."

parser = Parser::ThesisExamination.new
examinations = parser.examinations

examinations.each do |examination|
  ThesisExamination.where(examination).first_or_create!
end
