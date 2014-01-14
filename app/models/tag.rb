class Tag < ActiveRecord::Base
  has_many :file_tags
  has_many :files, through: :file_tags
end
