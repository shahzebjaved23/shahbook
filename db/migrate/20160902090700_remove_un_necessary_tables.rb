class RemoveUnNecessaryTables < ActiveRecord::Migration
  def change
  	drop_table :user_friends
  end
end
