class CreateActivityFeeds < ActiveRecord::Migration
  def change
    create_table :activity_feeds do |t|

    	t.string :targetable_name
    	t.integer :targetable_id

      t.timestamps null: false
    end
  end
end
