class AddRequestsTable < ActiveRecord::Migration
  def change
  	create_table :user_requests do |t|
  		t.integer :user_id
  		t.integer :friend_id
  	end
  end
end
