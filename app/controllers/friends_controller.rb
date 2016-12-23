class FriendsController < ApplicationController

	# Displays all the friends
	def index
		@friends = Friend.new(current_user).getAllFriends
	end
end
