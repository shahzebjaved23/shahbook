# This controller is responsible for showing the user data to another user  
# based on the user security settings

class UserProfileController < ApplicationController
  
  #  Shows the mains user public profile
  def index
    # get all the information about the user that the user is willing to show
    @user = User.find(params[:id])
    @photos = @user.getPhotos(current_user.id)
    @posts = @user.getPosts(current_user.id)
    @albums = @user.getAlbums(current_user.id)
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.getPosts(current_user.id)
  end

  def post
    @post = Post.find(params[:post_id])
  end

  def photos
    @user = User.find(params[:id])
    @photos = @user.getPhotos(current_user.id)
  end

  def photo
    @photo = Photo.find(params[:photo_id])
  end

  def albums
    @user = User.find(params[:id])
    @albums = @user.getAlbums(current_user.id)
  end

  def album
    @album = Albums.find(params[:album_id])
  end
end
