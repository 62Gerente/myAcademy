class CreateFicheiros < ActiveRecord::Migration
  def change
    create_table :ficheiros do |t|
      t.string :name
      t.references :folder, index: true
      t.references :subject, index: true
    end
  end
end
