class CreateFriendShips < ActiveRecord::Migration
  def change
    create_table :friend_ships do |t|

      t.boolean :friend_state
      t.integer :user_id
      t.integer :friends_id
      t.string :friend_level

      t.timestamps null: false
    end
  end
end
