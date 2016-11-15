class AddFriendRequestIdToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :friend_request_id, :integer
  end
end
