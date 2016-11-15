class AddStateToFriendShips < ActiveRecord::Migration
  def change
    add_column :friend_ships, :state, :string
  end
end
