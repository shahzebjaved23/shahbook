class AddCommentableIdToComments < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
  		t.integer :commentable_id
  		t.string :commentable_type
  		t.remove :post_id
  		t.remove :album_id
  		t.remove :photo_id
  	end
  end
end
