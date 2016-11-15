class Bio < ActiveRecord::Base
	belongs_to :user
	accepts_nested_attributes_for :user
	has_many :activity_feeds, as: :targetable
end
