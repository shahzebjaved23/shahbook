class RenameColumnInComments < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
  		t.rename :album_id_integer,:album_id
  	end
  end
end
