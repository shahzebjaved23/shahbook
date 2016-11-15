class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :album
	has_many :comments, as: :commentable

	has_one :security_setting , as: :securable
	has_many :activity_feeds, as: :targetable

	has_many :likes, as: :likeable

	has_attached_file :picture, default_url: "/images/"
	
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
