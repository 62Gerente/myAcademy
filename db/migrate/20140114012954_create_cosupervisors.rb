class CreateCosupervisors < ActiveRecord::Migration
  def change
    create_table :cosupervisors do |t|
      t.string :name
      t.references :teacher, index: true
      t.references :thesis_supervision, index: true
    end
  end
end
