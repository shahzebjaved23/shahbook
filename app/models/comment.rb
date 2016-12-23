class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :commentable, polymorphic: true
	
	has_many :activity_feeds, as: :targetable

	has_many :likes, as: :likeable

	has_many :replies, :class_name => "Comment" , :foreign_key => :reply_of_comment_id
	
	def getSecurityLevel
		self.commentable.security_setting.securitylevel
	end
end
