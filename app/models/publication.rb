class Publication < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :publication_type
  belongs_to :research_project
  has_many :authors
  has_many :editors
  has_many :deliverables
end
