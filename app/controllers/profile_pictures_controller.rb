class ProfilePicturesController < ApplicationController
	
	def new
		@profile_picture = ProfilePicture.new
	end

	def create
		@profile_picture = ProfilePicture.new(profile_picture_params)
		#  delete the previous one
		if current_user.profile_picture != nil
			current_user.profile_picture.picture.destroy
		end

		# create the new one
		current_user.profile_picture = @profile_picture
		if current_user.profile_picture.save
			flash[:notice] = "profile picture changed successfully"
			redirect_to user_path(current_user)
		else
			flash[:danger] = current_user.profile_picture.errors
			redirect_to user_path(current_user)
		end

	end

	def destroy
		current_user.profile_picture.picture.destroy
		current_user.profile_picture.destroy
		if current_user.save
			flash[:notice]="profile picture removed successfully"
		else
			flash[:danged] = "Unable to remove the profile picture"
		end
		redirect_to :back
	end

	private

	def profile_picture_params
		params.require(:profile_picture).permit(:picture)
	end
end
