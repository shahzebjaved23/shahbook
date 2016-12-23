class SearchController < ApplicationController
	def index
		@q = params[:q]
  		@search_results = User.where("first_name like ? OR last_name like ?", "%#{@q}%","%#{@q}%")
	end
end
