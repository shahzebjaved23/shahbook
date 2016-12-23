class FriendsController < ApplicationController
	def index
		@friends = Friend.new(current_user).getAllFriends
	end
end
