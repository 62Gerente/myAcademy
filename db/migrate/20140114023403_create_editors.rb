class CreateEditors < ActiveRecord::Migration
  def change
    create_table :editors do |t|
      t.string :name
      t.references :publication, index: true
      t.references :teacher, index: true
    end
  end
end
