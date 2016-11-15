class SearchController < ApplicationController
	def index
		@q = params[:q]
  		@search_results = User.joins(:bio).where("first_name like ? OR last_name like ?", "%#{@q}%","%#{@q}%")
	end
end
