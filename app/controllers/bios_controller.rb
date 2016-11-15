class BiosController < ApplicationController
  before_action :set_user
  before_action :check_user
  before_action :set_bio, except: [:new,:create]
  
  def show
  end

  def new
    @bio = Bio.new
  end

  def edit
  end

  def create
    @bio = Bio.new(bio_params)
    @bio.user = current_user
    
    respond_to do |format|
      if @bio.save
        format.html { redirect_to user_bio_path(@user), notice: 'Bio was successfully created.' }
        format.json { render :show, status: :created, location: @bio }
      else
        format.html { render :new }
        format.json { render json: @bio.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @bio = @user.bio
    
    respond_to do |format|
      if @bio.update(bio_params)
        format.html { redirect_to user_bio_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @bio.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bio.destroy
    respond_to do |format|
      format.html { redirect_to bios_url, notice: 'Bio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_bio
      @bio = @user.bio    
    end

    def set_user
      if User.where(id: params[:user_id]).count == 1
        @user = User.find(params[:user_id])
      else
        flash[:danger] = "Resource Not Found"
        redirect_to user_path(current_user)
      end
    end

    def check_user
      if @user != current_user
        flash[:danger] = "Resource not found"
        redirect_to user_path(current_user)
      end
    end

    def bio_params
      params.require(:bio).permit(:work_place, :designation, :college, :school, :university, :university_degree, :school_cert, :college_cert, :home_town)
    end
end
