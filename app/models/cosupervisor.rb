class Cosupervisor < ActiveRecord::Base
  belongs_to :thesis_supervision
  belongs_to :teacher
end
