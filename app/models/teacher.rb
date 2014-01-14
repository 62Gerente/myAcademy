class Teacher < ActiveRecord::Base
  belongs_to :institution
  has_many :hobbies
  has_many :academic_informations
  has_many :subjects
end
