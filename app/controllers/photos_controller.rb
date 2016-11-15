class PhotosController < ApplicationController
	
	before_action :set_user
	before_action :set_photo, only: [:show, :edit, :destroy]

	def index
		if @user == current_user
			@photos = @user.getPhotos
		else
			@photos = @user.getPhotos(current_user.id)
		end
	end

	def new 
		@photo = Photo.new 
	end

	# When a photo is creted inside an album, then the photo will inherit the security level of the album, other wise use the securitylevel_id from the params
	# when updated , the photo will always be updated using the securitylevel_id from the params, as photos can have different security level from the album 
	def create
		# create Photo from the params
		@photo = Photo.new(photo_params)

		# set the album if album_id exists in params
		if params.has_key?(:album_id)
			@photo.album_id = params[:album_id]
		end
		
		# if albums exists then photo inherits albums security level
		if @photo.album != nil
			@photo.security_setting.securitylevel_id = @photo.album.security_setting.securitylevel_id
		else
		# else set security level fromt the params
			@photo.security_setting.securitylevel_id = params[:securitylevel_id]
		end

		# set the user for the photo
		@photo.user = current_user
	
		respond_to do |format|
	    	if @photo.save
	        	current_user.createActivityFeed(@photo,"created")
	        	if params.has_key?(:album_id)
					format.html { redirect_to user_album_photo_path(@user,@photo.album,@photo), notice: 'photo was successfully updated.' }
				else
					format.html { redirect_to user_photo_path(@user,@photo), notice: 'photo was successfully updated.' }
				end
	        	format.json { render :show, status: :created, location: @photo }
	      	else
	        	format.html { render :new }
	        	format.json { render json: @photo.errors, status: :unprocessable_entity }
	      	end
	  	end
    end

	def edit
		# sets the photos from :user_id,:album_id(if present),:id from params
		# render the edit template
	end
	
	def update
		respond_to do |format|
	      	if @photo.update(photo_params)

	      		@photo.security_setting.securitylevel_id = params[:securitylevel_id]
	        	current_user.createActivityFeed(@photo,"updated")

			    if params.has_key?(:album_id)
					format.html { redirect_to user_album_photo_path(@user,@album,@photo), notice: 'photo was successfully updated.' }
				else
					format.html { redirect_to user_photo_path(@user,@photo), notice: 'photo was successfully updated.' }
				end
	        	format.json { render :show, status: :ok, location: @photo }
	      	else
	        	format.html { render :edit }
	        	format.json { render json: @photo.errors, status: :unprocessable_entity }
	      	end
	    end
	end

	def show
		# sets the photo from the user_id , album_id (if present), :id , in params
		# renders the show template
	end
	
	def destroy
		@photo.destroy
	    respond_to do |format|
	      format.html { redirect_to :back, notice: 'photo was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	end

	private

	def set_user
    	if User.where(id: params[:user_id]).count == 1
        @user = User.find(params[:user_id])
      else
        flash[:danger] = "Resource Not Found"
        redirect_to user_photos_path(current_user)
      end
    end

    def set_photo
    	if params.has_key?(:album_id)
    		@photo = Photo.find_by(id: params[:id],album_id: params[:album_id],user_id: @user.id)
    		if @photo == nil
    			flash[:danger] = "Resource dosent exist"
    			redirect_to user_path(@user)
    		end
	   	else
	   		@photo = Photo.find_by(id: params[:id],user_id: @user.id)
	    	if @photo == nil
	    		flash[:danger] = "Resource dosent exist"
	    		redirect_to user_path(@user)
	    	end
	   	end
    end 

    def photo_params
      params.require(:photo).permit(:id,:user_id,:caption,:picture)
    end
end
