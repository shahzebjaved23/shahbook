require "rails_helper"

describe FriendShip do
	
	it ".getFriendShip" do
		user1 = User.new(id: 1,first_name: "Shahzeb",last_name: "Javed",email: "something@something.com")
		friend_ship = create(:friend_ship,id: 1,user_id: 1,friends_id: 2,securitylevel1_id:1,securitylevel2_id:2,state: :done)
		ship = FriendShip.getFriendShip(user1,2)
		
		expect(ship).to eq(friend_ship)
	end

	it "isSentRequest?" do
		FriendShip.create(user_id: 1,friends_id: 2,state: :pending)
		friend_ship = FriendShip.isSentRequest?(1,2)
		expect(friend_ship).to be(true)
	end
end

