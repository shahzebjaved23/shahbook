class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	       :recoverable, :rememberable, :trackable, :validatable
	validates_presence_of :first_name,:last_name,:email
	
	has_many :posts
	has_many :photos
	has_many :albums
	has_many :comments
	has_one :interest
	has_one :bio
	has_many :activity_feeds
	has_one :profile_picture
	has_many :friend_ships
	has_many :friends, through: :friend_ships, class_name: 'User'

	
end

