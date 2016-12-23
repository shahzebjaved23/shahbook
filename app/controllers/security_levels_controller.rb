class SecurityLevelsController < ApplicationController
  
  def update
  	if params.has_key?(:friend_id)
  		
      updateFriendlevel
  	
    elsif params.has_key?(:post_id)
  	
    	updatePostSecurityLevel
  	
    elsif params.has_key?(:photo_id)
  	
    	updatePhotoSecurityLevel
  	
    elsif params.has_key?(:album_id)
  	
    	updateAlbumSecurityLevel
  	
    end		
  end

  private 

  def updateFriendlevel
    @friendship = FriendShip.getFriendShip(current_user.id,params[:friend_id])
    
    if @friendship.sender == current_user
      @friendship.update(securitylevel1_id: params[:securitylevel_id])
    elsif @friendship.reciever == current_user
      @friendship.update(securitylevel2_id: params[:securitylevel_id])
    end
    
    flash[:notice] = "Friend level changed successfully"
    redirect_to :back
  end

  def updatePostSecurityLevel
    @post = Post.find(params[:post_id])
    @post.security_setting.securitylevel_id = params[:securitylevel_id]
    @post.security_setting.save
    flash[:notice] = "security level changed successfully"
    redirect_to :back
  end

  def updateAlbumSecurityLevel
    @album = Album.find(params[:album_id])
    @album.security_setting.securitylevel_id = params[:securitylevel_id]
    @album.security_setting.save
    flash[:notice] = "security level changed successfully"
    redirect_to :back
  end

  def updatePhotoSecurityLevel
    @photo = Photo.find(params[:photo_id])
    @photo.security_setting.securitylevel_id = params[:securitylevel_id]
    @photo.security_setting.save
    flash[:notice] = "security level changed successfully"
    redirect_to :back
  end
end
