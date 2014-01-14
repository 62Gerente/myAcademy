class CreateThesisSupervisions < ActiveRecord::Migration
  def change
    create_table :thesis_supervisions do |t|
      t.datetime :b_date
      t.datetime :e_date
      t.text :description
      t.references :teacher, index: true
      t.references :thesis, index: true
    end
  end
end
