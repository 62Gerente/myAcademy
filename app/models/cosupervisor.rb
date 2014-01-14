class Cosupervisor < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :thesis_supervision
end
