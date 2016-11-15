class CommentsController < ApplicationController
	
	def create
		@comment = Comment.new(comment_params)
		@comment.user = current_user
		
		if params.has_key? :album_id
			@comment.commentable_type = "Album"
			@comment.commentable_id = params[:album_id]
		elsif params.has_key? :photo_id
			@comment.commentable_type = "Photo"
			@comment.commentable_id = params[:photo_id]
		elsif params.has_key? :post_id
			@comment.commentable_type = "Post"
			@comment.commentable_id = params[:post_id]
		end
				
		respond_to do |format|
	    	if @comment.save
	        	current_user.createActivityFeed(@comment,"created")
	        	format.html { redirect_to :back, notice: 'Comment was successfully created.' }
	        	format.json { render :show, status: :created, location: @comment }
	      	else
	        	format.html { render :new }
	        	format.json { render json: @comment.errors, status: :unprocessable_entity }
	      	end
	  	end
    end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
	    respond_to do |format|
	      format.html { redirect_to :back, notice: 'comment was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	end

	private
    
    def comment_params
      params.permit(:body,:user_id)
    end
end
