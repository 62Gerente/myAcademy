class AddFileToFicheiros < ActiveRecord::Migration
  def change
    add_attachment :ficheiros, :file
  end
end
