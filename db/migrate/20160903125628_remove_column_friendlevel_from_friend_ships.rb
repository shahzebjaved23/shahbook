class RemoveColumnFriendlevelFromFriendShips < ActiveRecord::Migration
  def change
  	remove_column :friend_ships , :friend_level, :string
  end
end
