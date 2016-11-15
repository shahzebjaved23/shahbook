class RequestsController < ApplicationController
	
	def index
		@requests = FriendShip.where(reciever: current_user, state: "pending")
	end
	
end
