class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :name
    end
  end
end
