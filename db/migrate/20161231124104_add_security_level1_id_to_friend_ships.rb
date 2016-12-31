class AddSecurityLevel1IdToFriendShips < ActiveRecord::Migration[5.0]
  def change
  	add_column :friend_ships, :securitylevel1_id, :integer
  end
end
