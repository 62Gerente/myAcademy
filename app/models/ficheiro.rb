class Ficheiro < ActiveRecord::Base
  belongs_to :subject
  belongs_to :folder
  has_many :file_tags
  has_attached_file :file
  has_many :tags, through: :file_tags
end
