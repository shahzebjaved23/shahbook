class SecuritySetting < ActiveRecord::Base
	belongs_to :securable, polymorphic: true
	belongs_to :securitylevel
end
