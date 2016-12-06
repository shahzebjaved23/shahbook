class Album < ActiveRecord::Base
	belongs_to :user
	has_many :photos
	has_many :comments , as: :commentable 
	has_many :activity_feeds, as: :targetable
	has_many :likes, as: :likeable

	has_one :security_setting, as: :securable

	def getSecurityLevel
		self.security_setting.securitylevel
	end
end
