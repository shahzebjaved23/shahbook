class AddUserIdToActivityFeeds < ActiveRecord::Migration
  def change
    add_column :activity_feeds, :user_id, :integer
  end
end
