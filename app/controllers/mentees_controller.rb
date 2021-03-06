class MenteesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mentee, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # load_and_authorize_resource :user
  # load_and_authorize_resource :mentee, :through => :user


  # GET /mentees
  # GET /mentees.json
  def index
    @user    = User.find_by( id: params[:user_id]) || current_user
    if(!current_user.has_role?(:admin) and current_user.id != @user.id)
      @user = current_user
    end
    @mentees = @user.mentees.page(params[:mentee_page])
    # p current_ability.inspect
    authorize! :read, *(@mentees.any? ? @mentees : @user.mentees.new)
    respond_to do |format|
      format.html
      format.js
    end
    
    # @mentees = Mentee.accessible_by(current_ability).page params[:page]
    # p current_ability.inspect
    # @ads = Ad.where("ads.published_at >= ?", 30.days.ago).accessible_by(current_ability)


  end
  
  def set_meeting_time

    $meeting_counter = $meeting_counter + params[:meeting_counter]
    $meeting_out_time = params[:meeting_out_time]
  end

  # GET /mentees/1
  # GET /mentees/1.json
  def show
    # events_meeting_time_remaining = []
    @coach_meetings = []

    @user    = User.find_by( id: params[:user_id]) || current_user
    @mentee = @user.mentees.find_by id: params[:id] if current_user.has_role?(:admin)
    if(@mentee.nil?)
      redirect_to user_path(current_user)
    else
      @goals = @mentee.goals.page(params[:goal_page]).per(PER_PAGE_RECORDS)
      @accomplishments = @mentee.accomplishments.order("id DESC").page(params[:accomplishment_page]).per(PER_PAGE_RECORDS)
      @comments = @mentee.comments.order("id DESC").page(params[:comment_page]).per(PER_PAGE_RECORDS)
      @tasks = @mentee.tasks.order("id DESC").page(params[:task_page]).per(PER_PAGE_RECORDS)
      @email_histories = @mentee.email_histories.order("id DESC").page(params[:email_page]).per(PER_PAGE_RECORDS)


      # @comments = @mentee.comments.order("id DESC")
      # @tasks = @mentee.tasks.order("id DESC")
      # @email_histories = @mentee.email_histories.order("id DESC")


      # @coach_mentee_relation_id = (CoachMenteeRelation.find_by mentee_id: @mentee.id).id
      @coach_mentee_relation_id = (@user.coach_mentee_relations.find_by mentee_id: @mentee.id).id
      # @coach_meetings     = @current_user.events.where("endtime >= ? and coach_mentee_relation_id = ?", Time.now, @coach_mentee_relation_id).order("starttime asc")

      @user.events.order("starttime").where("endtime >= ? and coach_mentee_relation_id = ?", Time.now, @coach_mentee_relation_id).order("starttime asc").each do |event|
        @coach_meetings << event if event.remaining_time > 0
      end

      unless @coach_meetings.kind_of?(Array)
        @coach_meetings = @coach_meetings.page(params[:meeting_page]).per(PER_PAGE_RECORDS)
      else
        @coach_meetings = Kaminari.paginate_array(@coach_meetings).page(params[:meeting_page]).per(PER_PAGE_RECORDS)
      end

      if(!current_user.has_role?(:admin) and current_user.id != @user.id)
        redirect_to user_mentee_path(current_user, @mentee)
      else
        # p @user.inspect
        authorize! :read, *(@mentee ? @mentee : @user.mentees.new)
        respond_to do |format|
          format.html
          format.js
        end
      end
    end
  end

  # GET /mentees/new
  def new
    @mentee = Mentee.new
  end

  # GET /mentees/1/edit
  def edit
  end

  # POST /mentees
  # POST /mentees.json
  def create
    @mentee = Mentee.new(mentee_params)

    respond_to do |format|
      if @mentee.save
        format.html { redirect_to @mentee, notice: 'Partner was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mentee }
      else
        format.html { render action: 'new' }
        format.json { render json: @mentee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mentees/1
  # PATCH/PUT /mentees/1.json
  def update
    respond_to do |format|
      if @mentee.update(mentee_params)
        format.html { redirect_to @mentee, notice: 'Partner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mentee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentees/1
  # DELETE /mentees/1.json
  def destroy
    @mentee.destroy
    respond_to do |format|
      format.html { redirect_to mentees_url }
      format.json { head :no_content }
    end
  end
  def time_diff(seconds_diff)
    seconds_diff = seconds_diff.to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  helper_method :time_diff
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mentee
      @mentee = Mentee.find_by(id: params[:id])
      if(@mentee.nil?)
        redirect_to user_path(current_user)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mentee_params
      params.require(:mentee).permit(:index, :show)
    end
end
