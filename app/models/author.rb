class Author < ActiveRecord::Base
  belongs_to :publication
  belongs_to :teacher
end
