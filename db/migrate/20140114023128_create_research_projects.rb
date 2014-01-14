class CreateResearchProjects < ActiveRecord::Migration
  def change
    create_table :research_projects do |t|
      t.string :name
      t.string :url
      t.datetime :b_date
      t.datetime :e_date
      t.text :description
      t.references :teacher, index: true
    end
  end
end
