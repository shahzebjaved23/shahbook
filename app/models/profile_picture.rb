class ProfilePicture < ActiveRecord::Base
	belongs_to :user

	has_attached_file :picture, default_url: "/images/"
	
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
