class SecurityLevelsController < ApplicationController
  
  def create
  	# update the security level on some resource of the current user
  	if params.has_key?(:friend_id)
  		# change the security setting of the friend with id = friend_id to
  		# security_level with id = params[:securitylevel_id]
  		@friendship = FriendShip.where(
  			"(user_id = #{current_user.id} AND friends_id = #{params[:friend_id]}) 
  				OR 
  			(user_id = #{params[:friend_id]} AND friends_id = #{current_user.id})"
  		).first
  		if @friendship.user_id == current_user.id
  			@friendship.update(securitylevel1_id: params[:securitylevel_id])
  		elsif @friendship.friends_id == current_user.id
  			@friendship.update(securitylevel2_id: params[:securitylevel_id])
  		end
  		flash[:notice] = "security level changed successfully"
  		redirect_to :back
  	elsif params.has_key?(:post_id)
  		@post = Post.find(params[:post_id])
  		@post.security_setting.securitylevel_id = params[:securitylevel_id]
  		@post.security_setting.save
  		flash[:notice] = "security level changed successfully"
  		redirect_to :back
  	elsif params.has_key?(:photo_id)
  		@photo = Photo.find(params[:photo_id])
  		@photo.security_setting.securitylevel_id = params[:securitylevel_id]
  		@photo.security_setting.save
  		flash[:notice] = "security level changed successfully"
  		redirect_to :back
  	elsif params.has_key?(:album_id)
  		@album = Album.find(params[:album_id])
  		@album.security_setting.securitylevel_id = params[:securitylevel_id]
  		@album.security_setting.save
  		flash[:notice] = "security level changed successfully"
  		redirect_to :back
  	end		
  end
end
