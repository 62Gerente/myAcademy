class AddPhotoToTeachers < ActiveRecord::Migration
  def change
    add_attachment :teachers, :photo
  end
end
