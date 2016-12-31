class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :album
	has_many :comments, as: :commentable

	has_one :security_setting , as: :securable
	has_many :activity_feeds, as: :targetable

	has_many :likes, as: :likeable

	has_attached_file :picture ,default_url: "/images/:styles/missing.png"
	
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

	def getSecurityLevel
		self.security_setting.securitylevel
	end

	def getPhotos(user,friendId = nil)
		if friendId != nil
			if friendId == user.id
				return user.photos
			end  
			if Friend.new(user).isFriendOf?(friendId)  
				return getSecurePhotos(user,friendId)
			else 
				return getPublicPhotos(user)
			end 
		else
			return user.photos 
		end
	end	

	private

	def getPublicPhotos user
		Photo.where(id: SecuritySetting.select(:securable_id).where(securable: user.photos,securitylevel: Securitylevel.find_by(Securitylevel: "Public")))
	end

	def getSecurePhotos(user,friendId)
		Photo.where(id: SecuritySetting.select(:securable_id).where(securable: user.photos).where("securitylevel_id >= (?)",Friend.new(user).getFriendLevel(friendId).id + 1))
	end
end
