class CreateFileTags < ActiveRecord::Migration
  def change
    create_table :file_tags do |t|
      t.references :file, index: true
      t.references :tag, index: true
    end
  end
end
