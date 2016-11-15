class FriendShip < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend , class_name: "User", foreign_key: :friends_id
	has_many :activity_feeds, as: :targetable

	belongs_to :friendlevel2,class_name: "Friendlevel", foreign_key: :securitylevel2_id
	belongs_to :friendlevel1,class_name: "Friendlevel", foreign_key: :securitylevel1_id

	belongs_to :sender, class_name: "User", foreign_key: :user_id
	belongs_to :reciever , class_name: "User", foreign_key: :friends_id
    
    # static method
	def self.getFriendShip(friendId1,friendId2)
		FriendShip.where("((user_id = ? AND friends_id = ?) OR (user_id = ? AND friends_id = ?)) AND state = 'done'",friendId1,friendId2,friendId2,friendId1).first
	end

	def self.isSentRequest?(friendId1,friendId2)
		request = FriendShip.where("((user_id = ? AND friends_id = ?) OR (user_id = ? AND friends_id = ?)) AND state = 'pending'",friendId1,friendId2,friendId2,friendId1)
		if request.count == 0
			return false
		else
			return true
		end
	end
end
