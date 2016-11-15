class ActivityFeedsController < ApplicationController

	def index
		if params[:user_id].to_i == current_user.id
			@activity_feeds = current_user.getActivityFeeds
		else
			flash[:danger] = "cannot locate resource"
			redirect_to user_activity_feeds_path(current_user)
		end
	end
end
