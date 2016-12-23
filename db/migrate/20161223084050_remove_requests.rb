class RemoveRequests < ActiveRecord::Migration[5.0]
  def change
  	drop_table :requests
  	drop_table :books
  	drop_table :movies
  	drop_table :interests
  	remove_column :friend_ships, :friend_state
  	remove_column :activity_feeds, :targetable_name
  end
end
