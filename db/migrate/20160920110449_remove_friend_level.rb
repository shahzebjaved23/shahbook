class RemoveFriendLevel < ActiveRecord::Migration
  def change
  	# drop_table :friendlevels
  	# rename_column :friend_ships, :friendlevel_id, :securitylevel1_id
  	rename_column :friend_ships, :friend_level2_id, :securitylevel2_id
  end
end
