class AcademicInformation < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :course
  belongs_to :institution
  belongs_to :academic_degree
end
