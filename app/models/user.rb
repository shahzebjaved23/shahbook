class User < ActiveRecord::Base
	
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	       :recoverable, :rememberable, :trackable, :validatable
	
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
		FriendShip.where(reciever: self, state: "pending")
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
		if friendId != nil 
			if(self.isFriendOf?(friendId))
		 		return self.getSecurePhotos(friendId)
		 	else
		 		return getPublicPhotos
		 	end
	 	else
	 		return self.photos
	 	end
	end

	def getAlbums(friendId = nil)
		if friendId != nil 
			if(self.isFriendOf?(friendId))
		 		return self.getSecureAlbums(friendId)
		 	else
		 		return getPublicAlbums
		 	end
	 	else
	 		return self.albums
	 	end
	end

	def getPosts(friendId = nil)
		if friendId != nil 
			if(self.isFriendOf?(friendId))
		 		return self.getSecurePosts(friendId)
		 	else
		 		return getPublicPosts
		 	end
	 	else
	 		return self.posts
	 	end
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
		friendsIds = self.getAllFriends.map(&:id)
		ActivityFeed.where("
			(
				user_id in (?) 
					AND 
				(
					securitylevel_id >= 
						(
							select friend_ships.securitylevel2_id+1 from friend_ships where 
								(
									user_id = #{self.id} AND friends_id in (?)
								) limit 1
						) 
						OR 
					securitylevel_id >= 
						(
							select friend_ships.securitylevel1_id+1 from friend_ships where 
								(
									user_id in (?) AND friends_id = #{self.id}
								) limit 1
						)
				)
			) 
				OR
			(
				(
					targetable_type = 'Post' 
						AND
					targetable_id in 
							(
								select posts.id from posts where user_id = #{self.id}
							)
				)
					OR
				(
					targetable_type = 'Album' 
						AND
					targetable_id in 
							(
								select albums.id from albums where user_id = #{self.id}
							)
				)
					OR
				(
					targetable_type = 'Photo' 
						AND
					targetable_id in 
							(
								select photos.id from photos where user_id = #{self.id}	
							)
				)
					OR
				(
					targetable_type = 'Comment' 
						AND
					targetable_id in 
					(
						select comments.id from comments where
						(
							commentable_type = 'Post'
								AND
							commentable_id in 
									(
										select posts.id from posts where user_id = #{self.id}	
									)
						)
							OR
						(
							commentable_type = 'Album'
								AND
							commentable_id in 
									(
										select albums.id from albums where user_id = #{self.id}
									)
						)
							OR
						(
							commentable_type = 'Photo'
								AND
							commentable_id in 
									(
										select photos.id from photos where user_id = #{self.id}
									)
						)
							OR
						(
							comments.user_id = #{self.id}
						)
						
					)
				)
					OR
				(
					targetable_type = 'Like' 
						AND
					targetable_id in 
						(
							select likes.id from likes where
							(
								likeable_type = 'Post'
									AND
								likeable_id in 
										(
											select posts.id from posts where user_id = #{self.id}	
										)
							)
								OR
							(
								likeable_type = 'Album'
									AND
								likeable_id in 
										(
											select albums.id from albums where user_id = #{self.id}
										)
							)
								OR
							(
								likeable_type = 'Photo'
									AND
								likeable_id in 
										(
											select photos.id from photos where user_id = #{self.id}
										)
							)
								OR
							(
								user_id = #{self.id}
							)
							
						)
				)
			)",friendsIds,friendsIds,friendsIds).order("activity_feeds.created_at DESC")
	end

	# ***************************************************************************************

	# ---------------------------------------------------------------------------------------
	# creates new activity feed of the user
	# called on the current logged in user (current_user)
	# every time a user created or updates a new information, a new entry in the table is created
	# ---------------------------------------------------------------------------------------

	def createActivityFeed(type,action)
		securitylevel_id = nil;
		if type.class.name == "Comment"
			if type.commentable_type == "Post"
				securitylevel_id = Post.find(type.commentable_id).security_setting.securitylevel.id
			elsif type.commentable_type == "Photo"
				securitylevel_id = Photo.find(type.commentable_id).security_setting.securitylevel.id
			elsif type.commentable_type == "Album"
				securitylevel_id = Album.find(type.commentable_id).security_setting.securitylevel.id
			end
		end
					
		activity_feed = ActivityFeed.create(
			targetable_id: type.id,
			targetable_type: type.class.name,
			securitylevel_id: securitylevel_id == nil ? type.security_setting.securitylevel.id : securitylevel_id,
			status: action,
			user_id: self.id
		)
	end

	# Method that returns all the friends

	def getAllFriends
		User.where("
			users.id IN 
				(
					select friend_ships.user_id from friend_ships where 
						friend_ships.friends_id = #{self.id} and friend_ships.state = 'done'
				) 
				OR 
			users.id IN 
				(
					select friend_ships.friends_id from friend_ships where 
						friend_ships.user_id = #{self.id} and friend_ships.state = 'done'
				)
		")
	end

	# Method to check if a certain user is a friend of ther user this method is called upon
	def isFriendOf?(friendId)
		self.getAllFriends.include?(User.find(friendId))		
	end

	#----------------------------------------------------------------------------------------
	# Private methods for getting the requested information
	# Called on the user object whose information is being requested
	# friendId is the id of the user who requests the information
	#----------------------------------------------------------------------------------------
	
	def getFriendLevel(friendId)
		Friendlevel.where("
			id IN 
				(
					select friend_ships.securitylevel1_id from friend_ships 
						where (user_id = #{self.id} and friends_id = #{friendId})
				) 
				OR 
			id IN 
				(
					select friend_ships.securitylevel2_id from friend_ships 
						where (user_id = #{friendId} and friends_id = #{self.id})
				) 
		").first
	end
	
	def getPublicPhotos
		Photo.joins(:user).joins("
			INNER JOIN 
				security_settings ON security_settings.securable_id = photos.id 
			INNER JOIN 
				securitylevels ON security_settings.securitylevel_id = securitylevels.id 
			").where("
				securitylevels.id = 5 
			AND 
				security_settings.securable_type = 'Photo' 
			AND 
				users.id = #{self.id}")
	end

	def getPublicAlbums
		Album.joins(:user).joins("
			INNER JOIN 
				security_settings ON security_settings.securable_id = albums.id 
			INNER JOIN 
				securitylevels ON security_settings.securitylevel_id = securitylevels.id 
			").where("securitylevels.id = 5 
			AND 
				security_settings.securable_type = 'Album' 
			AND 
				users.id = #{self.id}")
	end

	def getPublicPosts
		Post.joins(:user).joins("
			INNER JOIN 
				security_settings ON security_settings.securable_id = posts.id 
			INNER JOIN 
				securitylevels ON security_settings.securitylevel_id = securitylevels.id ")
		.where("securitylevels.id = 5 
			AND 
				security_settings.securable_type = 'Post' 
			AND 
				users.id = #{self.id}")
	end

	# if friend level is close friend
	# 	return all the photos whith security level == close friend, friend,acquaintance
	# if friend level is friend
	# 	return all the photos with security level == friend , acquaintance
	# if friend level is acquaintance
	# 	return all the photos with security level == acquaintance
	# if not a friend
	#  return all the public photos

	def getSecurePhotos(friendId)
		friendlevel = self.getFriendLevel(friendId)

		if friendlevel.id == 1
			return Photo.joins(:user).joins("
				INNER JOIN 
					security_settings ON security_settings.securable_id = photos.id 
				INNER JOIN 
					securitylevels ON security_settings.securitylevel_id = securitylevels.id ").where("(securitylevels.id = '2' 
									OR
								securitylevels.id = '3'
									OR
								securitylevels.id = '4'
								OR
								securitylevels.id = '5')  
					AND 
						security_settings.securable_type = 'Photo' 
					AND 
						users.id = #{self.id}")
		elsif friendlevel.id == 2
			return Photo.joins(:user).joins("
				INNER JOIN 
					security_settings ON security_settings.securable_id = photos.id 
				INNER JOIN 
					securitylevels ON security_settings.securitylevel_id = securitylevels.id ").where("(securitylevels.id = '3'
									OR
								securitylevels.id = '4'
									OR
								securitylevels.id = '5')  
					AND 
						security_settings.securable_type = 'Photo' 
					AND 
						users.id = #{self.id}")
		elsif friendlevel.id == 3
			return Photo.joins(:user).joins("
				INNER JOIN 
					security_settings ON security_settings.securable_id = photos.id 
				INNER JOIN 
					securitylevels ON security_settings.securitylevel_id = securitylevels.id ").where("(securitylevels.id = '4'
									OR
								securitylevels.id = '5')  
					AND 
						security_settings.securable_type = 'Photo' 
					AND 
						users.id = #{self.id}")
		end	
	end

	def getSecureAlbums(friendId)
		friendlevel = self.getFriendLevel(friendId)

		if friendlevel.id == 1
			return Album.joins(:user).joins("
				INNER JOIN 
					security_settings ON security_settings.securable_id = albums.id 
				INNER JOIN 
					securitylevels ON security_settings.securitylevel_id = securitylevels.id ").where("(securitylevels.id = '2' 
									OR
								securitylevels.id = '3'
									OR
								securitylevels.id = '4'
									OR
								securitylevels.id = '5')  
					AND 
						security_settings.securable_type = 'Album' 
					AND 
						users.id = #{self.id}")
		elsif friendlevel.id == 2
			return Album.joins(:user).joins("
				INNER JOIN 
					security_settings ON security_settings.securable_id = albums.id 
				INNER JOIN 
					securitylevels ON security_settings.securitylevel_id = securitylevels.id ").where("(securitylevels.id = '3'
									OR
								securitylevels.id = '4'
									OR
								securitylevels.id = '5')  
					AND 
						security_settings.securable_type = 'Album' 
					AND 
						users.id = #{self.id}")
		elsif friendlevel.id == 3
			return Album.joins(:user).joins("
				INNER JOIN 
					security_settings ON security_settings.securable_id = albums.id 
				INNER JOIN 
					securitylevels ON security_settings.securitylevel_id = securitylevels.id ").where("(securitylevels.id = '4'
									OR
								securitylevels.id = '5')  
					AND 
						security_settings.securable_type = 'Album' 
					AND 
						users.id = #{self.id}")
		end
	end

	def getSecurePosts(friendId)
		friendlevel = self.getFriendLevel(friendId)

		if friendlevel.id == 1
			return Post.joins(:user).joins("
				INNER JOIN 
					security_settings ON security_settings.securable_id = posts.id 
				INNER JOIN 
					securitylevels ON security_settings.securitylevel_id = securitylevels.id ").where("(securitylevels.id = '2' 
									OR
								securitylevels.id = '3'
									OR
								securitylevels.id = '4'
									OR
								securitylevels.id = '5')  
					AND 
						security_settings.securable_type = 'Post' 
					AND 
						users.id = #{self.id}")
		elsif friendlevel.id == 2
			return Post.joins(:user).joins("
				INNER JOIN 
					security_settings ON security_settings.securable_id = posts.id 
				INNER JOIN 
					securitylevels ON security_settings.securitylevel_id = securitylevels.id ").where("(securitylevels.id = '3'
									OR
								securitylevels.id = '4'
									OR
								securitylevels.id = '5')  
					AND 
						security_settings.securable_type = 'Post' 
					AND 
						users.id = #{self.id}")
		elsif friendlevel.id == 3
			return Post.joins(:user).joins("
				INNER JOIN 
					security_settings ON security_settings.securable_id = posts.id 
				INNER JOIN 
					securitylevels ON security_settings.securitylevel_id = securitylevels.id ").where("(securitylevels.id = '4'
									OR
								securitylevels.id = '5')  
					AND 
						security_settings.securable_type = 'Post' 
					AND 
						users.id = #{self.id}")
		end
	end		
end

