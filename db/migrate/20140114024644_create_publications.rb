class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.string :url
      t.datetime :date
      t.text :description
      t.text :address
      t.string :pages
      t.string :publisher
      t.string :journal
      t.string :volume
      t.string :book_title
      t.string :isbn
      t.string :issn
      t.text :how_published
      t.references :publication_type, index: true
      t.references :teacher, index: true
      t.references :research_project, index: true
    end
  end
end
