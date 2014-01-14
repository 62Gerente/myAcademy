class Activity < ActiveRecord::Base
  belongs_to :activity_type
  belongs_to :teacher
end
