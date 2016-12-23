class ActivityFeed < ActiveRecord::Base
	belongs_to :targetable, polymorphic: true
	belongs_to :user
	belongs_to :securitylevel
	
	validates :securitylevel_id, presence: true
	validates :targetable_id, presence: true
	validates :targetable_type, presence: true
	validates :user_id, presence: true

	def getActivityFeeds(user)		
		ActivityFeed.where(user: senders(user)).where("securitylevel_id >= (?)",senderSecurityLevel(user)).or(ActivityFeed.where(user: recievers(user)).where("securitylevel_id >= (?)",recieverSecurityLevel(user))).or(ActivityFeed.where(user: user)).order("created_at DESC")
	end

	def createActivityFeed(user,type,action)
		activity_feed = ActivityFeed.create(targetable_id: type.id,targetable_type: type.class.name,securitylevel_id: type.getSecurityLevel.id,status: action, user: user)
	end

	private

	def senders user
		User.where(id: FriendShip.select(:user_id).where(reciever: user,state: :done))
	end
	
	def recievers user
		User.where(id: FriendShip.select(:friends_id).where(sender: user,state: :done))
	end

	def senderSecurityLevel user
		FriendShip.select("securitylevel1_id + 1").where(sender: Friend.new(user).getAllFriends,reciever:user).limit(1)
	end

	def recieverSecurityLevel user 
		FriendShip.select("securitylevel2_id + 1").where(sender: user,reciever: Friend.new(user).getAllFriends).limit(1)
	end
end
