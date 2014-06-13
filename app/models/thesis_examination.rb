class ThesisExamination < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :thesis

  delegate :title,:student, :url, :institution, :academic_degree, to: :thesis
end
