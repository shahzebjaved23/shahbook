class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :likeable, polymorphic: true

	def getSecurityLevel
		self.likeable.security_setting.securitylevel
	end
end
