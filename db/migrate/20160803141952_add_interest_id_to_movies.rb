class AddInterestIdToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :interest_id, :integer
  end
end
