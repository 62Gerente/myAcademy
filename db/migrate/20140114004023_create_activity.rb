class CreateActivity < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :url
      t.datetime :b_date
      t.datetime :e_date
      t.text :description
      t.references :teacher, index: true
      t.references :activity_type, index: true
    end
  end
end
