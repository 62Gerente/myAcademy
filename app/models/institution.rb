class Institution < ActiveRecord::Base
  has_many :teachers
  has_many :courses
  has_many :theses
end 
