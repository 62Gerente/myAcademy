class CreateTheses < ActiveRecord::Migration
  def change
    create_table :theses do |t|
      t.string :title
      t.string :url
      t.string :student
      t.references :academic_degree, index: true
      t.references :institution, index: true
    end
  end
end
