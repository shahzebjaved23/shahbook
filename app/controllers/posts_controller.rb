class PostsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: [:show, :edit, :destroy]
  
  # GET /posts
  # GET /posts.json
  def index
    @profile = Profile.new(@user)
    @posts = @profile.getPostsForUser(current_user.id)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.user = current_user
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.security_setting = SecuritySetting.new
    @post.security_setting.securitylevel = Securitylevel.find(params[:securitylevel_id])

    
    respond_to do |format|
      if @post.save
        ActivityFeed.new.createActivityFeed(current_user,@post,"created")
        format.html { redirect_to user_posts_path(current_user,@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        ActivityFeed.new.createActivityFeed(current_user,@post,"updated")
        @post.security_setting.securitylevel_id = params[:securitylevel_id]
        @post.security_setting.save
        format.html { redirect_to user_post_path(current_user,@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_path(current_user), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by(id: params[:id],user_id: params[:user_id])
      if @post == nil
        flash[:danger] = "Resource Desent Exist" 
        redirect_to user_path(current_user)
      end
    end

    def set_user
      if User.where(id: params[:user_id]).count == 1
        @user = User.find(params[:user_id])
      else
        flash[:danger] = "Resource Not Found"
        redirect_to user_posts_path(current_user)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end
