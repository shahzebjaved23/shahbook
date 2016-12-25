class FriendShip < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend , class_name: "User", foreign_key: :friends_id
	has_many :activity_feeds, as: :targetable

	belongs_to :friendlevel2,class_name: "Friendlevel", foreign_key: :securitylevel2_id
	belongs_to :friendlevel1,class_name: "Friendlevel", foreign_key: :securitylevel1_id

	belongs_to :sender, class_name: "User", foreign_key: :user_id
	belongs_to :reciever , class_name: "User", foreign_key: :friends_id

    def self.getFriendShip(friendId1,friendId2)
    	(FriendShip.where(user_id: friendId1,friends_id: friendId2).or(FriendShip.where(user_id: friendId2, friends_id: friendId1))).where(state: :done).first
	end

	def self.getFriendShipRelation(friendId1,friendId2)
    	(FriendShip.where(user_id: friendId1,friends_id: friendId2).or(FriendShip.where(user_id: friendId2, friends_id: friendId1))).where(state: :done)
	end

	def self.isSentRequest?(friendId1,friendId2)
		request = (FriendShip.where(user_id: friendId1,friends_id: friendId2).or(FriendShip.where(user_id: friendId2, friends_id: friendId1))).where(state: :pending)
		request.count != 0
	end

	def self.getFriendLevel user,friend
		FriendShip.select("securitylevel1_id").where(sender: user,reciever: friend).or(FriendShip.select("securitylevel2_id").where(sender: friend,reciever: user))
	end
end
