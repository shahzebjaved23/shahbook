class ActivityFeedsController < ApplicationController

	respond_to :json,:html

	def index
		if params[:user_id].to_i == current_user.id
			if params.has_key? :since 
				since = DateTime.strptime(params[:since],'%s')
				@activity_feeds = ActivityFeed.new.getActivityFeeds(current_user).where("created_at > ?",since) 
			else
				@activity_feeds = ActivityFeed.new.getActivityFeeds(current_user).limit(10)
			end
			respond_with @activity_feeds
		else
			redirect_to user_activity_feeds_path(current_user)			 
		end
	end

end
