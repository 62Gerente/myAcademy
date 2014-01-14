class CreateAcademicInformations < ActiveRecord::Migration
  def change
    create_table :academic_informations do |t|
      t.datetime :b_date
      t.datetime :e_date
      t.text :escription
      t.float :grade
      t.references :academic_degree, index: true
      t.references :course, index: true
      t.references :institution, index: true
      t.references :teacher, index: true
    end
  end
end
