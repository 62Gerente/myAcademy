class FileTag < ActiveRecord::Base
  belongs_to :file
  belongs_to :tag
end
