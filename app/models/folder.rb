class Folder < ActiveRecord::Base
  belongs_to :subject
  belongs_to :folder
  has_many :ficheiros
  has_many :folders
end
