class CreatePublicationTypes < ActiveRecord::Migration
  def change
    create_table :publication_types do |t|
      t.string :name
    end
  end
end
