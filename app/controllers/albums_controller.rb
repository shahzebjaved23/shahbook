class AlbumsController < ApplicationController
	
	before_action :set_user 
	before_action :set_album, only: [:show, :edit, :destroy]
	

	def index
		@profile = Profile.new(@user)
		@albums = @profile.getAlbumsForUser(current_user.id)
	end

	def show
		# sets an album from :user_id and :album_id in params
		# render the show template
	end

	def new
		@album = Album.new 
	end

	def create
		@album = Album.new(album_params)
		@album.security_setting = SecuritySetting.new
		@album.security_setting.securitylevel_id = params[:securitylevel_id]
		@album.user = current_user

		respond_to do |format|
	    	if @album.save
	        	ActivityFeed.new.createActivityFeed(@album,"created")
	        	format.html { redirect_to user_album_path(@user,@album), notice: 'Post was successfully created.' }
	        	format.json { render :show, status: :created, location: @album }
	      	else
	        	format.html { render :new }
	        	format.json { render json: @album.errors, status: :unprocessable_entity }
	      	end
	  	end
    end

	def edit
		# sets @photo from :user_id,:album_id from params
	 	# render the edit template 
	end
	
	def update
		respond_to do |format|
	      	if @album.update(album_params)
	        	ActivityFeed.new.createActivityFeed(@album,"updated")

	        	format.html { redirect_to @album, notice: 'album was successfully updated.' }
	        	format.json { render :show, status: :ok, location: @album }
	      	else
	        	format.html { render :edit }
	        	format.json { render json: @album.errors, status: :unprocessable_entity }
	      	end
	    end
	end
	
	def destroy
		@album.destroy
	    respond_to do |format|
	      format.html { redirect_to posts_url, notice: 'album was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	end

	private
    
    def set_album
    	@album = Album.find_by(id: params[:id],user_id: @user.id)
    	if @album == nil
    		flash[:danger] = "Resource does not Exist"
    		redirect_to user_albums_path(@user)
    	end
    end

    def set_user
    	if User.where(id: params[:user_id]).count == 1
	        @user = User.find(params[:user_id])
	    else
	    	flash[:danger] = "Resource Not Found"
	        redirect_to user_path(current_user)
	    end
    end

    def album_params
    	params.require(:album).permit(:id,:title,:user_id)
    end
end
