require "rails_helper"

describe Friend do

	let!(:user1){ create(:user,id:1) }
	
	context "testing getFriendRequests method" do

		let!(:friend_ship1){ create(:friend_ship,user_id: 2,friends_id:1,state: "pending")}
		let!(:friend_ship2){ create(:friend_ship,user_id: 3,friends_id:1,state: "pending")}

		it "gets all the friend reqests"  do
			requests = Friend.new(user1).getFriendRequests 
			expect(requests).to match_array([friend_ship1,friend_ship2])
		end
	end

	context "testing getAllFriends method" do
		
		let!(:friend_ship1){ create(:friend_ship,user_id: 1,friends_id:2,state: "done")}
		let!(:friend_ship2){ create(:friend_ship,user_id: 1,friends_id:3,state: "done")}
		let!(:user2){ create(:user,id:2) }
		let!(:user3){ create(:user,id:3) }
		
		it "gets all the friends" do
			friends = Friend.new(user1).getAllFriends
			expect(friends).to match_array([user2,user3])
		end
	end

	context "testing getFriendLevel(friendId) method" do
		
		let!(:friend_ship1){ create(:friend_ship,user_id: 1,friends_id:2,securitylevel1_id:1)}
		let!(:friend_ship2){ create(:friend_ship,user_id: 3,friends_id:1,securitylevel2_id:2)}
		
		it "get the friend level" do 
			friendlevels = []
			friendlevels.push(Friend.new(user1).getFriendLevel(2).id)
			friendlevels.push(Friend.new(user1).getFriendLevel(3).id)

			expect(friendlevels).to match_array([1,2])
		end
	end

	context "testing isFriendOf?(friendId) method" do

		let!(:friend_ship1){ create(:friend_ship,user_id: 1,friends_id:2,securitylevel1_id:1)}
			
		it "checks if is friend of a user" do 	
			isfriend = Friend.new(user1).isFriendOf?(2)
			expect(isfriend).to be(true)
		end
	end
end