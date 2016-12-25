class ActivityBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
	ActivityFeedsChannel.broadcast_to(data[:user].id,data[:feed]) 
  end
end
