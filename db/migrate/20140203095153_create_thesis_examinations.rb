class CreateThesisExaminations < ActiveRecord::Migration
  def change
    create_table :thesis_examinations do |t|
      t.datetime :date
      t.text :description
      t.references :thesis, index: true
      t.references :teacher, index: true
    end
  end
end
