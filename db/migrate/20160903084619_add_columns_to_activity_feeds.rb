class AddColumnsToActivityFeeds < ActiveRecord::Migration
  def change
  	add_column :activity_feeds, :status, :string
  end
end
