class ActivityBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
  	user = data[:user]
  	activity_feed = data[:feed]
  	html = ApplicationController.render(partial: "activity_feeds/activity_feed", locals: { activity_feed: activity_feed }, formats: [:html])
	ActivityFeedsChannel.broadcast_to(user.id,html) 
  end
end


