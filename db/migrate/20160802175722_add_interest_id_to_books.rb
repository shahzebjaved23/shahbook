class AddInterestIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :interest_id, :integer
  end
end
