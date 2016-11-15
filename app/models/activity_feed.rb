class ActivityFeed < ActiveRecord::Base
	belongs_to :targetable, polymorphic: true
	belongs_to :user
	belongs_to :securitylevel
end
