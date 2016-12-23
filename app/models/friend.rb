class Friend
	def initialize user
		@user = user
	end

	def getFriendRequests
		FriendShip.where(reciever: @user, state: :pending) 
	end

	def getAllFriends	
		User.where(id: senders).or(User.where(id: recievers)) 
	end

	def getFriendLevel(friendId)
		Friendlevel.where(id: senderFriendLevel(friendId)).or(Friendlevel.where(id: recieverFriendLevel(friendId))).first
	end

	def isFriendOf?(friendId)
		FriendShip.getFriendShipRelation(@user.id,friendId).where(state: :done).count == 1	
	end

	private
	
	def senders
		FriendShip.select(:user_id).where(reciever: @user,state: :done)
	end

	def recievers 
		FriendShip.select(:friends_id).where(sender: @user,state: :done)
	end

	def senderFriendLevel friendId
		FriendShip.select(:securitylevel1_id).where(user_id: @user.id,friends_id: friendId)
	end

	def recieverFriendLevel friendId 
		FriendShip.select(:securitylevel2_id).where(user_id: friendId,friends_id: @user.id)
	end
end