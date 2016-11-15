class ProfilePicturesController < ApplicationController
	
	def new
		if current_user.profile_picture != nil
			@profile_picture = current_user.profile_picture
		else
			@profile_picture = ProfilePicture.new
		end
	end

	def create
		@profile_picture = ProfilePicture.new(profile_picture_params)
		if current_user.profile_picture != nil
			current_user.profile_picture.picture.destroy
		end
		current_user.profile_picture = @profile_picture
		current_user.profile_picture.save
		redirect_to user_path(current_user)
	end

	def destroy
		current_user.profile_picture.picture.destroy
		current_user.profile_picture.destroy
		current_user.save
		redirect_to :back
	end

	private

	def profile_picture_params
		params.require(:profile_picture).permit(:picture)
	end
end
