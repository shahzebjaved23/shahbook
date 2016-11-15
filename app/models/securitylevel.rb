class Securitylevel < ActiveRecord::Base
	has_many :security_settings
	has_many :friend_ships
end
