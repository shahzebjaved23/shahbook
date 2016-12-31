class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, as: :commentable
	has_many :activity_feeds, as: :targetable
	has_one :security_setting, as: :securable
	has_many :likes, as: :likeable

	validates :title, presence: true
	validates :body, presence: true

	def getSecurityLevel
		self.security_setting.securitylevel
	end

	def getPosts(user,friendId = nil)
		if friendId != nil
			if friendId == user.id
				return user.posts
			end  
			if Friend.new(user).isFriendOf?(friendId)  
				return getSecurePosts(user,friendId)
			else 
				return getPublicPosts(user)
			end 
		else
			return user.posts 
		end
	end

	private

	def getPublicPosts user
		Post.where(id: SecuritySetting.select(:securable_id).where(securable: user.posts,securitylevel: Securitylevel.find_by(Securitylevel: "Public")))
	end

	def getSecurePosts(user,friendId)
		Post.where(id: SecuritySetting.select(:securable_id).where(securable: user.posts).where("securitylevel_id >= (?)",Friend.new(user).getFriendLevel(friendId).id + 1))
	end		
end


