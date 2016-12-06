class User < ActiveRecord::Base
	
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	       :recoverable, :rememberable, :trackable, :validatable

	validates :first_name, presence: true
	validates :last_name,presence: true

	
	has_many :posts
	has_many :photos
	has_many :albums
	has_many :comments
	has_one :interest
	has_one :bio
	has_many :activity_feeds
	has_one :security_setting , as: :securable
	has_one :profile_picture
	has_many :friend_ships
	has_many :friends, through: :friend_ships, class_name: 'User'

	
	# Method that returns all the FreindShip records where the state is pending 
	# i.e pending requests
	def getFriendRequests
		FriendShip.where(reciever: self, state: :pending)
	end

	# Method that returns all the friends
	def getAllFriends
		senders = FriendShip.select(:user_id).where(reciever: self,state: :done)
		recievers = FriendShip.select(:friends_id).where(sender: self,state: :done)
		
		User.where(id: senders).or(User.where(id: recievers))
	end

	# Method to check if a certain user is a friend of ther user this method is called upon
	def isFriendOf?(friendId)
		self.getAllFriends.include?(User.find(friendId))		
	end

	
	# ---------------------------------------------------------------------------------------
	# Methods that return user infromation based on the users security setting on that 
	# information 
	# They will be called on the users object so self refresents the user
	# WHOSE INFORMATION IS BEING REQUESTED
	# 
	# The friendId represents the id of the user WHO REQUESTS THE INFORMATION
	# This will be the current logged in user (current_user)
	# ---------------------------------------------------------------------------------------
	
	# If the person requesting the information is a friend than return the information
	# according to the security level of that friend , assigned by the user
	# else retrun only the public information

	def getPhotos(friendId = nil)
		friendId != nil ? self.isFriendOf?(friendId) ? self.getSecurePhotos(friendId): self.getPublicPhotos : self.photos  
		# if friendId != nil 
		# 	if(self.isFriendOf?(friendId))
		#  		return self.getSecurePhotos(friendId)
		#  	else
		#  		return getPublicPhotos
		#  	end
	 # 	else
	 # 		return self.photos
	 # 	end
	end

	def getAlbums(friendId = nil)
		friendId != nil ? self.isFriendOf?(friendId) ? self.getSecureAlbums(friendId): self.getPublicAlbums : self.albums 
		# if friendId != nil 
		# 	if(self.isFriendOf?(friendId))
		#  		return self.getSecureAlbums(friendId)
		#  	else
		#  		return getPublicAlbums
		#  	end
	 # 	else
	 # 		return self.albums
	 # 	end
	end

	def getPosts(friendId = nil)
		friendId != nil ? self.isFriendOf?(friendId) ? self.getSecurePosts(friendId): self.getPublicPosts : self.posts 
		# if friendId != nil 
		# 	if(self.isFriendOf?(friendId))
		#  		return self.getSecurePosts(friendId)
		#  	else
		#  		return getPublicPosts
		#  	end
	 # 	else
	 # 		return self.posts
	 # 	end
	end

	# ***************************************************************************************

	# ---------------------------------------------------------------------------------------
	# gets all the activity feeds of the user
	# to be called on the current user so the self represents the current logged in user
	# gets the activity feeds such that 
	# the user_id is in the friends id
	# and the securitylevel matches the level set by friend on that user
	# ---------------------------------------------------------------------------------------
	def getActivityFeeds
		# check that the user is a friend of the current user
		# then check if the securitylevel_id of the targetable is greater than or equal to the friend level set by user plus one
		
		senders = User.where(id: FriendShip.select(:user_id).where(reciever: self,state: :done))
		recievers = User.where(id: FriendShip.select(:friends_id).where(sender: self,state: :done))

		senderSecurityLevel = FriendShip.select("securitylevel1_id + 1").where(sender: self.getAllFriends,reciever:self).limit(1)

		recieverSecurityLevel = FriendShip.select("securitylevel2_id + 1").where(sender: self,reciever: self.getAllFriends).limit(1)

		ActivityFeed.where(user: senders).where("securitylevel_id >= (?)",senderSecurityLevel).or(ActivityFeed.where(user: recievers).where("securitylevel_id >= (?)",recieverSecurityLevel)).or(ActivityFeed.where(user: self))
	end

	# ***************************************************************************************

	# ---------------------------------------------------------------------------------------
	# creates new activity feed of the user
	# called on the current logged in user (current_user)
	# every time a user created or updates a new information, a new entry in the table is created
	# ---------------------------------------------------------------------------------------
	def createActivityFeed(type,action)
		# set the security level id of the resource that the comment or like references
		
		securitylevel_id = type.getSecurityLevel
		
		# if type.class.name == "Comment"	 
		# 	if type.commentable_type == "Post"
		# 		securitylevel_id = Post.find(type.commentable_id).security_setting.securitylevel.id
		# 	elsif type.commentable_type == "Photo"
		# 		securitylevel_id = Photo.find(type.commentable_id).security_setting.securitylevel.id
		# 	elsif type.commentable_type == "Album"
		# 		securitylevel_id = Album.find(type.commentable_id).security_setting.securitylevel.id
		# 	end
		# elsif type.class.name == "Like"
		# 	if type.likeable_type == "Post"
		# 		securitylevel_id = Post.find(type.commentable_id).security_setting.securitylevel.id
		# 	elsif type.likeable_type == "Photo"
		# 		securitylevel_id = Photo.find(type.commentable_id).security_setting.securitylevel.id
		# 	elsif type.likeable_type == "Album"
		# 		securitylevel_id = Album.find(type.commentable_id).security_setting.securitylevel.id
		# 	end
		# end
					
		activity_feed = ActivityFeed.create(
			targetable_id: type.id,
			targetable_type: type.class.name,
			securitylevel_id: securitylevel_id == nil ? type.security_setting.securitylevel.id : securitylevel_id,
			status: action,
			user_id: self.id
		)
	end

	#----------------------------------------------------------------------------------------
	# Methods for getting the requested information
	# Called on the user object whose information is being requested
	# friendId is the id of the user who requests the information
	#----------------------------------------------------------------------------------------
	
	def getFriendLevel(friendId)
		senderFriendLevel = FriendShip.select(:securitylevel1_id).where(user_id: self.id,friends_id: friendId)

		recieverFriendLevel = FriendShip.select(:securitylevel2_id).where(user_id: friendId,friends_id: self.id)

		Friendlevel.where(id: senderFriendLevel).or(Friendlevel.where(id: recieverFriendLevel)).first
	end

	# following methods are used to get the public resouces
	def getPublicPhotos
		Photo.where(id: SecuritySetting.select(:securable_id).where(securable: self.photos,securitylevel: Securitylevel.find_by(Securitylevel: "Public")))
	end

	def getPublicAlbums
		Album.where(id: SecuritySetting.select(:securable_id).where(securable: self.albums,securitylevel: Securitylevel.find_by(Securitylevel: "Public")))
	end

	def getPublicPosts
		Post.where(id: SecuritySetting.select(:securable_id).where(securable: self.posts,securitylevel: Securitylevel.find_by(Securitylevel: "Public")))
	end

	# The following methods are used to get a users secured resources for another user
	def getSecurePhotos(friendId)
		Photo.where(id: SecuritySetting.select(:securable_id).where(securable: self.photos).where("securitylevel_id >= (?)",self.getFriendLevel(friendId).friendlevel))
	end

	def getSecureAlbums(friendId)
		Album.where(id: SecuritySetting.select(:securable_id).where(securable: self.albums).where("securitylevel_id >= (?)",self.getFriendLevel(friendId).friendlevel))
	end

	def getSecurePosts(friendId)
		Post.where(id: SecuritySetting.select(:securable_id).where(securable: self.posts).where("securitylevel_id >= (?)",self.getFriendLevel(friendId).friendlevel))
	end		
end

