class Management < ActiveRecord::Base
  belongs_to :role
  belongs_to :entity
  belongs_to :teacher
end
