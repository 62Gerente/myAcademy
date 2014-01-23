class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.string :chapter
      t.string :pages
      t.string :publisher
      t.string :doi
      t.string :volume
      t.string :isbn
      t.string :issn
      t.datetime :date
      t.string :booktitle
      t.string :address
      t.string :uri
      t.string :journal
      t.string :number
      t.string :howpublished
      t.string :school
      t.references :publication_type, index: true
      t.references :teacher, index: true
      t.references :research_project, index: true
    end
  end
end
