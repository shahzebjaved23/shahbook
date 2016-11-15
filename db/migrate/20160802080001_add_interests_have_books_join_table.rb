class AddInterestsHaveBooksJoinTable < ActiveRecord::Migration
  def change
  	create_table :interest_books do |t|
  		t.integer :interest_id
  		t.integer :book_id
  	end
  end
end
