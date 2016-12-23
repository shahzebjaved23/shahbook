class RequestsController < ApplicationController
	
	# displays all the requests
	def index
		@requests = FriendShip.where(reciever: current_user, state: "pending")
	end

	# sends a new friend request
	def create
		@reciever = User.find(params[:id])
	    @sender_security_level_id = params[:sender_security_level_id]

	  	if FriendShip.create(sender: current_user, reciever: @reciever, 
	    	securitylevel1_id: @sender_security_level_id,state: "pending")
	    	flash[:notice] = "Friend Request sent"
	    	redirect_to :back
	    else
	    	flash[:notice] = "Unable to send Friend Request"
	    	redirect_to :back
	    end
	end

	# accepts a friend request
	def update
		@friendship = FriendShip.find(params[:id])
	    @friendship.securitylevel2_id = params[:reciever_security_setting_id]
	    @friendship.state = "done"

	    if @friendship.save 
	    	flash[:notice] = "friend succussfully added"
	  		redirect_to :back
	    else
	    	flash[:notice] = "Unable to accept the friend request"
	    	redirect_to :back
	    end
	end

	# cancels a friend request
	def destroy
		@friendship = FriendShip.find(params[:id])
	  	@friendship.destroy
	  	flash[:notice] = "friend request cancelled"
	  	redirect_to :back
	end
end
