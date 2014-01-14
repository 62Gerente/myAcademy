class CreateAcademicDegrees < ActiveRecord::Migration
  def change
    create_table :academic_degrees do |t|
      t.string :name
    end
  end
end
