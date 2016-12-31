require "rails_helper"

describe Album do
	context "testing getAlbums(friendId = nil) method" do
			
			let!(:user0){create(:user,id:0)}
			let!(:user1){create(:user,id:1)}
			let!(:user2){create(:user,id:2)}
			let!(:user3){create(:user,id:3)}
			let!(:user4){create(:user,id:4)}

			let!(:friendship1){create(:friend_ship,user_id:1,friends_id:2,securitylevel1_id: 1)}
			let!(:friendship2){create(:friend_ship,user_id:1,friends_id:3,securitylevel1_id: 2)}
			let!(:friendship3){create(:friend_ship,user_id:1,friends_id:4,securitylevel1_id: 3)}

			let!(:album0){
				create(:security_setting,id:1,securable_type: "Album",securable_id: 1,securitylevel_id:1)
				create(:album,id:0,user_id:1)
			}
			
			let!(:album1){
				create(:security_setting,id:2,securable_type: "Album",securable_id: 1,securitylevel_id:2)
				create(:album,id:1,user_id:1)
			}
			
			let!(:album2){
				create(:security_setting,id:3,securable_type: "Album",securable_id: 2,securitylevel_id:3)
				create(:album,id:2,user_id:1)
			}
			
			let!(:album3){
				create(:security_setting,id:4,securable_type: "Album",securable_id: 3,securitylevel_id:4)
				create(:album,id:3,user_id:1)
			}
			
			let!(:album4){
				create(:security_setting,id:5,securable_type: "Album",securable_id: 4,securitylevel_id:5)
				create(:album,id:4,user_id:1)
			}


		it "gets all albums for himself , Private" do
			albums = build(:album).getAlbums(user1,1)
			expect(albums).to match_array([album0,album1,album2,album3,album4])
		end
	
		it "gets albums of a user who is a Close Friend" do
			albums = build(:album).getAlbums(user1,2)
			expect(albums).to match_array([album1,album2,album3,album4])
		end

		it "gets albums of a user who is a Friend" do
			albums = build(:album).getAlbums(user1,3)
			expect(albums).to match_array([album2,album3,album4])
		end

		it "gets albums of a user who is an Acquaintance" do
			albums = build(:album).getAlbums(user1,4)
			expect(albums).to match_array([album3,album4])
		end

		it "gets albums of a user who is not a friend , Public" do
			albums = build(:album).getAlbums(user1,0)
			expect(albums).to match_array([album4])
		end

	end
end