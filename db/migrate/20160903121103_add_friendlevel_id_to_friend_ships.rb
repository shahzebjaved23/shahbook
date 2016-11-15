class AddFriendlevelIdToFriendShips < ActiveRecord::Migration
  def change
    add_column :friend_ships, :friendlevel_id, :integer
  end
end
