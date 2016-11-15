class AddPhotoIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :photo_id, :integer
    add_column :comments, :album_id_integer, :string
  end
end
