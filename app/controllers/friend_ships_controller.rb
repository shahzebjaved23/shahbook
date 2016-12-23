class FriendShipsController < ApplicationController
  
  # new friendship model created when a user sends a friend request 
  def create
  	@reciever = User.find(params[:id])
    @sender_security_level_id = params[:sender_security_level_id]

  	if FriendShip.create(sender: current_user, reciever: @reciever, 
    	securitylevel1_id: @sender_security_level_id,state: "pending")
    
      redirect_to :back
    end
  end

  # friendship model updated when a user eiher accepts a friend request 
  def update
  	# get the friends ship model , using the request_id from the params
    @friendship = FriendShip.find(params[:id])
    @friendship.securitylevel2_id = params[:reciever_security_setting_id]
    @friendship.state = "done"

    if @friendship.save 
      flash[:notice] = "friend succussfully added"
  	  redirect_to :back
    end
  end

  # freindship model is destroyed when user cancels a friend request
  def destroy
  	@friendship = FriendShip.find(params[:id])
  	@friendship.destroy
  	flash[:notice] = "friend request cancelled"
  	redirect_to :back
  end
end
