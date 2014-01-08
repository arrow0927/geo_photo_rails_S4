class AddcolumnToPhotos < ActiveRecord::Migration
  def up
    add_column  :photos, :description, :string
    add_column  :photos, :takenby, :string
  end

  def down
  end
end
