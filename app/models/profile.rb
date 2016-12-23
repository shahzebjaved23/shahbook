class Profile
	attr_accessor :posts,:photos,:albums

	def initialize user
		@user = user
	end

	def getPostsForUser userId
		Post.new.getPosts(@user,userId)
	end

	def getPhotosForUser userId
		Photo.new.getPhotos(@user,userId)
	end

	def getAlbumsForUser userId
		Album.new.getAlbums(@user,userId)
	end

end