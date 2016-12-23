class WelcomeController < ApplicationController

	skip_before_action :authenticate_user!
  	
  	# shows the index page
  	def index
  	end

  	# shows the about page 
  	def about
  	end
end
