class ChangeColTypeOfPhoto < ActiveRecord::Migration
  def up
    change_column :photos, :lat, :string
    change_column :photos, :lng, :string
  end

  def down
  end
end
