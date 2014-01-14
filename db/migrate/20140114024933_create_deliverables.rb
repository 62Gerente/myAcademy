class CreateDeliverables < ActiveRecord::Migration
  def change
    create_table :deliverables do |t|
      t.string :url
      t.references :publication, index: true
    end
  end
end
