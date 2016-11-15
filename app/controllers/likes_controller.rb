class LikesController < ApplicationController

	# While creating, focus on who creates the like
	# and on what resource it creates the like
	def create
		@like = Like.new(user_id: current_user.id)
		
		if params.has_key?(:photo_id)
			if params.has_key?(:comment_id)
				@like.likeable_type = "Comment"
				@like.likeable_id = params[:comment_id]
			else
				@like.likeable_type = "Photo"
				@like.likeable_id = params[:photo_id]
			end
		elsif params.has_key?(:post_id)
			if params.has_key?(:comment_id)
				@like.likeable_type = "Comment"
				@like.likeable_id = params[:comment_id]
			else
				@like.likeable_type = "Post"
				@like.likeable_id = params[:post_id]
			end
		elsif params.has_key?(:album_id)
			if params.has_key?(:photo_id)
				if params.has_key?(:comment_id)
					@like.likeable_type = "Comment"
					@like.likeable_id = params[:comment_id]
				else
					@like.likeable_type = "Photo"
					@like.likeable_id = params[:photo_id]
				end
			elsif params.has_key?(:comment_id)
				@like.likeable_type = "Comment"
				@like.likeable_id = params[:comment_id]
			else
				@like.likeable_type = "Album"
				@like.likeable_id = params[:album_id]
			end
		end

		flash[:danger] = "liked Successfully"
		@like.save
		redirect_to :back					
	end

	# invoked when someone unlikes someone
	# the destroying functionality is simple, simply destroy the like with the like_id
	def destroy
		@like = Like.find(params[:id])
		@like.destroy
		flash[:danger] = "Unliked Successfully"
		redirect_to :back
	end

end
