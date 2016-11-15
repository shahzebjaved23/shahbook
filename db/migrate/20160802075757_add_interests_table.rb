class AddInterestsTable < ActiveRecord::Migration
  def change
  	create_table :interests do |t|
  		t.integer :user_id
  	end
  end
end
