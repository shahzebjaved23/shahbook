class ActivityBroadcastJob < ApplicationJob
  queue_as :default

  def perform(activity_feed)
	ActivityFeedsChannel.broadcast_to(current_user.id,activity_feed) 
  end
end
