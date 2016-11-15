class Interest < ActiveRecord::Base
	belongs_to :user
	has_many :books, :join_table => :interest_books
	has_many :movies, :join_table => :interest_movies
end
