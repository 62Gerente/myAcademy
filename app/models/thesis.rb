class Thesis < ActiveRecord::Base
  belongs_to :academic_degree
  belongs_to :institution
end
