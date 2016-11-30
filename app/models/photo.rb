class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :album
	has_many :comments, as: :commentable

	has_one :security_setting , as: :securable
	has_many :activity_feeds, as: :targetable

	has_many :likes, as: :likeable

	has_attached_file :picture,styles: { medium: "300x300>", thumb: "100x100>" } ,default_url: "/images/:styles/missing.png"
	
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/	
end
