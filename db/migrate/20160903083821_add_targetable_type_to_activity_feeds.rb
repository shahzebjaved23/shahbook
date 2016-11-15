class AddTargetableTypeToActivityFeeds < ActiveRecord::Migration
  def change
    add_column :activity_feeds, :targetable_type, :string
  end
end
