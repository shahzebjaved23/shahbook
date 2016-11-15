class AddInterestsHaveMoviesJoinTable < ActiveRecord::Migration
  def change
  	create_table :interest_movies do |t|
  		t.integer :interest_id
  		t.integer :movie_id
  	end
  end
end
