require "rails_helper"

describe Post do
	context "testing getPosts(friendId = nil) method" do
			
			let!(:user0){create(:user,id:0)}
			let!(:user1){create(:user,id:1)}
			let!(:user2){create(:user,id:2)}
			let!(:user3){create(:user,id:3)}
			let!(:user4){create(:user,id:4)}

			let!(:friendship1){create(:friend_ship,user_id:1,friends_id:2,securitylevel1_id: 1)}
			let!(:friendship2){create(:friend_ship,user_id:1,friends_id:3,securitylevel1_id: 2)}
			let!(:friendship3){create(:friend_ship,user_id:1,friends_id:4,securitylevel1_id: 3)}

			let!(:post0){
				create(:security_setting,id:1,securable_type: "Post",securable_id: 1,securitylevel_id:1)
				create(:post,id:0,user_id:1)
			}
			
			let!(:post1){
				create(:security_setting,id:2,securable_type: "Post",securable_id: 1,securitylevel_id:2)
				create(:post,id:1,user_id:1)
			}
			
			let!(:post2){
				create(:security_setting,id:3,securable_type: "Post",securable_id: 2,securitylevel_id:3)
				create(:post,id:2,user_id:1)
			}
			
			let!(:post3){
				create(:security_setting,id:4,securable_type: "Post",securable_id: 3,securitylevel_id:4)
				create(:post,id:3,user_id:1)
			}
			
			let!(:post4){
				create(:security_setting,id:5,securable_type: "Post",securable_id: 4,securitylevel_id:5)
				create(:post,id:4,user_id:1)
			}


		it "gets all posts for himself , Private" do
			posts = build(:post).getPosts(user1,1)
			expect(posts).to match_array([post0,post1,post2,post3,post4])
		end
	
		it "gets posts of a user who is a Close Friend" do
			posts = build(:post).getPosts(user1,2)
			expect(posts).to match_array([post1,post2,post3,post4])
		end

		it "gets posts of a user who is a Friend" do
			posts = build(:post).getPosts(user1,3)
			expect(posts).to match_array([post2,post3,post4])
		end

		it "gets posts of a user who is an Acquaintance" do
			posts = build(:post).getPosts(user1,4)
			expect(posts).to match_array([post3,post4])
		end

		it "gets posts of a user who is not a friend , Public" do
			posts = build(:post).getPosts(user1,0)
			expect(posts).to match_array([post4])
		end

	end
end