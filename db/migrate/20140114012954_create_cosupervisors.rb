class CreateCosupervisors < ActiveRecord::Migration
  def change
    create_table :cosupervisors do |t|
      t.string :name
      t.string :institution
      t.references :thesis_supervision, index: true
    end
  end
end
