require "rails_helper"

describe ActivityFeed do

	context "testing #users method" do

		let!(:user1){ create(:user,id: 1) }
		let!(:user2){ create(:user,id: 2) }
		let!(:user3){ create(:user,id: 3) }
		let!(:user4){ create(:user,id: 4) }

		let!(:ship1){create(:friend_ship,user_id: 1,friends_id: 2,securitylevel1_id:1,state: :done)}
		let!(:ship2){create(:friend_ship,user_id: 1,friends_id: 3,securitylevel1_id:2,state: :done)}
		let!(:ship3){create(:friend_ship,user_id: 1,friends_id: 4,securitylevel1_id:3,state: :done)}

		it "#users : returns close friends from securitylevel_id:2" do
			users = ActivityFeed.new(user_id: 1,securitylevel_id: 2).users
			expect(users).to match_array([user1,user2])
		end


		it "#users : returns Friends for securitylevel_id:3" do
			users = ActivityFeed.new(user_id: 1,securitylevel_id: 3).users
			expect(users).to match_array([user1,user2,user3])
		end

		it "#users : returns Acquaintances for securitylevel_id:4" do
			users = ActivityFeed.new(user_id: 1,securitylevel_id: 4).users
			expect(users).to match_array([user1,user2,user3,user4])
		end
	end

	context "testing #getActivityFeeds method" do
		let!(:user1){ create(:user,id: 1) }
		let!(:user2){ create(:user,id: 2) }
		let!(:user3){ create(:user,id: 3) }
		let!(:user4){ create(:user,id: 4) }

		let!(:ship1){create(:friend_ship,user_id: 1,friends_id: 2,securitylevel1_id:1)}
		let!(:ship2){create(:friend_ship,user_id: 1,friends_id: 3,securitylevel1_id:2)}
		let!(:ship3){create(:friend_ship,user_id: 1,friends_id: 4,securitylevel1_id:3)}

		let!(:activityfeed1){create(:activity_feed,user_id: 1,securitylevel_id: 2)}
		let!(:activityfeed2){create(:activity_feed,user_id: 1,securitylevel_id: 3)}
		let!(:activityfeed3){create(:activity_feed,user_id: 1,securitylevel_id: 4)}
		
		it "returns close friends for securitylevel_id: 2" do
			useractivityfeeds = ActivityFeed.new().getActivityFeeds(user2)
			expect(useractivityfeeds).to match_array([activityfeed1,activityfeed2,activityfeed3])
		end
		it "returns friends for securitylevel_id:3" do 
			useractivityfeeds = ActivityFeed.new().getActivityFeeds(user3)
			expect(useractivityfeeds).to match_array([activityfeed2,activityfeed3])
		end
		it "returns Acquaintances for securitylevel_id:4" do
			useractivityfeeds = ActivityFeed.new().getActivityFeeds(user4)
			expect(useractivityfeeds).to match_array([activityfeed3])
		end
	end

end