class Folder < ActiveRecord::Base
  belongs_to :subject
  belongs_to :folder
  has_many :files
  has_many :folders
end
