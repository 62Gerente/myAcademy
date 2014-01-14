class CreateManagements < ActiveRecord::Migration
  def change
    create_table :managements do |t|
      t.datetime :b_date
      t.datetime :e_date
      t.text :description
      t.references :teacher, index: true
      t.references :role, index: true
      t.references :entity, index: true
    end
  end
end
