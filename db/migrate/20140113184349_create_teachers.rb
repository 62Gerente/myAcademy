class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :status
      t.string :phone
      t.string :email
      t.datetime :birthday
      t.string :url
      t.text :bio
      t.boolean :registed
      t.references :institution, index: true
    end
  end
end
