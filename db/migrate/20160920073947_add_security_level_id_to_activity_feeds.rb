class AddSecurityLevelIdToActivityFeeds < ActiveRecord::Migration
  def change
    add_column :activity_feeds, :securitylevel_id, :integer
  end
end
