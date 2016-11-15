class AddFriendLevelIdToFriendShip < ActiveRecord::Migration
  def change
  	add_column :friend_ships, :friend_level2_id, :integer
  end
end
