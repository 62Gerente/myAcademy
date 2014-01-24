class Teacher < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :institution
  has_many :hobbies
  has_many :academic_informations
  has_many :subjects
  has_many :managements
  has_many :activities
  has_many :thesis_supervisions
  has_many :thesis_examinations
  has_many :research_projects
  has_many :thesis_supervisions, through: :cosupervisors
  has_many :authors
  has_many :publications_authored, through: :authors, source: :publication
  has_many :editors
  has_many :publications_editor, through: :editors, source: :publication
  has_many :cosupervisors

  has_attached_file :photo
end
