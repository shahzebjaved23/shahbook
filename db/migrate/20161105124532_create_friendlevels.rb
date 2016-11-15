class CreateFriendlevels < ActiveRecord::Migration
  def change
    create_table :friendlevels do |t|
      t.string :friendlevel

      t.timestamps null: false
    end
  end
end
