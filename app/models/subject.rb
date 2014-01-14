class Subject < ActiveRecord::Base
  has_many :folders
  has_many :files
  belongs_to :course
  belongs_to :teacher
end
