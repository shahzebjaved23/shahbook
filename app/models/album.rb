class Album < ActiveRecord::Base
	belongs_to :user
	has_many :photos
	has_many :comments , as: :commentable 
	has_many :activity_feeds, as: :targetable
	has_many :likes, as: :likeable

	has_one :security_setting, as: :securable

	def getSecurityLevel
		self.security_setting.securitylevel
	end

	def getAlbums(user,friendId = nil)
		if friendId != nil
			if friendId == user.id
				return user.albums
			end  
			if Friend.new(user).isFriendOf?(friendId)  
				return getSecureAlbums(user,friendId)
			else 
				return getPublicAlbums(user)
			end 
		else
			return user.albums 
		end
	end

	private

	def getPublicAlbums user
		Album.where(id: SecuritySetting.select(:securable_id).where(securable: user.albums,securitylevel: Securitylevel.find_by(Securitylevel: "Public")))
	end

	def getSecureAlbums(user,friendId)
		Album.where(id: SecuritySetting.select(:securable_id).where(securable: user.albums).where("securitylevel_id >= (?)",Friend.new(user).getFriendLevel(friendId).friendlevel))
	end
end
