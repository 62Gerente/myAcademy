class ResearchProject < ActiveRecord::Base
  belongs_to :teacher
  has_many :publications
end
