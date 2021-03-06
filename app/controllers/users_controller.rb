class UsersController < ApplicationController
  before_action :authenticate_user!

  #before_action :set_coach, only: [:show, :edit]
  before_action :set_user

  # GET /useres
  # GET /useres.json
  def index
    @users = User.coach.search(params)
    # @users = User.coach.search(params).page(params[:page]).per(5)
    # @goals = @mentee.goals.page(params[:page]).per(5)
    authorize! :read, @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # @user = current_user
    # UserMailer.registration_confirmation(@user).deliver
    # authorize! :read, @user
    if(!current_user.has_role?(:admin) and current_user.id != @user.id)
      redirect_to user_path(current_user)
    end
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  # GET /coaches/new
  #def new
  #  @coach = Coach.new
  #end
  #
  ## GET /coaches/1/edit
  # def edit
  # end
  #
  ## POST /coaches
  ## POST /coaches.json
  #def create
  #  @coach = Coach.new(coach_params)
  #
  #  respond_to do |format|
  #    if @coach.save
  #      format.html { redirect_to @coach, notice: 'Coach was successfully created.' }
  #      format.json { render action: 'show', status: :created, location: @coach }
  #    else
  #      format.html { render action: 'new' }
  #      format.json { render json: @coach.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## PATCH/PUT /coaches/1
  ## PATCH/PUT /coaches/1.json
  #def update
  #  respond_to do |format|
  #    if @coach.update(coach_params)
  #      format.html { redirect_to @coach, notice: 'Coach was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @coach.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## DELETE /coaches/1
  ## DELETE /coaches/1.json
  #def destroy
  #  @coach.destroy
  #  respond_to do |format|
  #    format.html { redirect_to coaches_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.coach.find_by(:id => params[:id]) || current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :address, :home_phone, :availablity_time, :best_time_to_call, :date_of_birth)
    end
end
