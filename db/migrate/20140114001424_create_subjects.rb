class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :students
      t.string :academic_year
      t.text :description
      t.references :course, index: true
      t.references :teacher, index: true
    end
  end
end
