class ThesisSupervision < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :thesis
  has_many :cosupervisors
end
