class CreateHobbies < ActiveRecord::Migration
  def change
    create_table :hobbies do |t|
      t.string :activity
      t.datetime :b_date
      t.datetime :e_date
      t.text :description
      t.references :teacher, index: true
    end
  end
end
