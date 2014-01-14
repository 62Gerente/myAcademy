class Editor < ActiveRecord::Base
  belongs_to :publication
  belongs_to :teacher
end
