require 'parsers/thesis_supervision'
puts "seeding thesis supervisions..."

parser = Parser::ThesisSupervision.new
supervisions = parser.supervisions
cosupervisors = parser.cosupervisors

supervisions.each do |supervision|
  ThesisSupervision.where(supervision).first_or_create!
end

cosupervisors.each do |cosupervisor|
  Cosupervisor.where(cosupervisor).first_or_create!
end
