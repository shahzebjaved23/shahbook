require "rails_helper"

describe Photo do
	context "testing getphotos(friendId = nil) method" do
			
			let!(:user0){create(:user,id:0)}
			let!(:user1){create(:user,id:1)}
			let!(:user2){create(:user,id:2)}
			let!(:user3){create(:user,id:3)}
			let!(:user4){create(:user,id:4)}

			let!(:friendship1){create(:friend_ship,user_id:1,friends_id:2,securitylevel1_id: 1)}
			let!(:friendship2){create(:friend_ship,user_id:1,friends_id:3,securitylevel1_id: 2)}
			let!(:friendship3){create(:friend_ship,user_id:1,friends_id:4,securitylevel1_id: 3)}

			let!(:photo0){
				create(:security_setting,id:1,securable_type: "photo",securable_id: 1,securitylevel_id:1)
				create(:photo,id:0,user_id:1)
			}
			
			let!(:photo1){
				create(:security_setting,id:2,securable_type: "photo",securable_id: 1,securitylevel_id:2)
				create(:photo,id:1,user_id:1)
			}
			
			let!(:photo2){
				create(:security_setting,id:3,securable_type: "photo",securable_id: 2,securitylevel_id:3)
				create(:photo,id:2,user_id:1)
			}
			
			let!(:photo3){
				create(:security_setting,id:4,securable_type: "photo",securable_id: 3,securitylevel_id:4)
				create(:photo,id:3,user_id:1)
			}
			
			let!(:photo4){
				create(:security_setting,id:5,securable_type: "photo",securable_id: 4,securitylevel_id:5)
				create(:photo,id:4,user_id:1)
			}


		it "gets all photos for himself , Private" do
			photos = build(:photo).getPhotos(user1,1)
			expect(photos).to match_array([photo0,photo1,photo2,photo3,photo4])
		end
	
		it "gets photos of a user who is a Close Friend" do
			photos = build(:photo).getPhotos(user1,2)
			expect(photos).to match_array([photo1,photo2,photo3,photo4])
		end

		it "gets photos of a user who is a Friend" do
			photos = build(:photo).getPhotos(user1,3)
			expect(photos).to match_array([photo2,photo3,photo4])
		end

		it "gets photos of a user who is an Acquaintance" do
			photos = build(:photo).getPhotos(user1,4)
			expect(photos).to match_array([photo3,photo4])
		end

		it "gets photos of a user who is not a friend , Public" do
			photos = build(:photo).getPhotos(user1,0)
			expect(photos).to match_array([photo4])
		end

	end
end