require 'parsers/thesis_examination'
puts "seeding thesis examinations..."

examinations = Parser::ThesisExamination.new.get_examinations

examinations.each do |thesis|
  ThesisExamination.where(thesis).first_or_create!
end
