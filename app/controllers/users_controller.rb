class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

 
  # GET /users/1
  # GET /users/1.json
  def show
    @profile = Profile.new(@user)
    @posts = @profile.getPostsForUser(current_user.id)
    @photos = @profile.getPhotosForUser(current_user.id)
    @albums = @profile.getAlbumsForUser(current_user.id)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
  
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if User.where(id: params[:id]).count == 1
        @user = User.find(params[:id])
      else
        flash[:danger] = "Resource Not Found - user not found having the specified user id"
        redirect_to user_path(current_user)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_id,:first_name, :last_name, :bio_id)
    end
end
