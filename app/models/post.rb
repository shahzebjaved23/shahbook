class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, as: :commentable
	has_many :activity_feeds, as: :targetable
	has_one :security_setting, as: :securable
	has_many :likes, as: :likeable

	def getSecurityLevel
		self.security_setting.securitylevel
	end
end


