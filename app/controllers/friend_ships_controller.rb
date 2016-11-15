class FriendShipsController < ApplicationController
  
  # new friendship model created when a user sends a friend request 
  def create
  	# find the user to whom the request is sent
  	@reciever = User.find(params[:id])

  	# set the security level that sender set for the reciever
  	@sender_security_level_id = params[:sender_security_level_id]

  	# create the model with sender as the current_user.
    FriendShip.create(sender: current_user, reciever: @reciever, 
    	securitylevel1_id: @sender_security_level_id,state: "pending")
    redirect_to :back
  end

  # a friendship model updated when a user eiher accepts a friend request 
  def update
  	# get the friends ship model , using the request_id from the params
    @friendship = FriendShip.find(params[:id])
    
    # set the security level, reciever assigns to the sender
    @friendship.securitylevel2_id = params[:reciever_security_setting_id]
    
    # set the state to done
    @friendship.state = "done"

    # save the friendship
    @friendship.save 
  	
  	flash[:notice] = "friend succussfully added"
  	redirect_to :back
  end

  # a freindship model is destroyed when user cancels a friend request
  def destroy
  	# find the friendship model and destroy it
  	@friendship = FriendShip.find(params[:id])
  	@friendship.destroy
  	flash[:notice] = "friend request cancelled"
  	redirect_to :back
  end
end
