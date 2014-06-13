class ThesisSupervision < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :thesis
  has_many :cosupervisors

  delegate :title,:student, :url, :institution, :academic_degree, to: :thesis

end
