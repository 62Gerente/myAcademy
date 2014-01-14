class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.references :publication, index: true
      t.references :teacher, index: true
    end
  end
end
