class SkillsController < ApplicationController
  # Render mobile or desktop depending on User-Agent for these actions.
  before_filter :check_for_mobile #, :only => [:new, :edit]

  # Always render mobile versions for these, regardless of User-Agent.
  #before_filter :prepare_for_mobile, :only => :show
  
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  before_action :set_notifications
  before_filter :authenticate_user!
  before_action :subscribed_user#, :only => [:show, :new, :edit]

  # GET /skills
  # GET /skills.json
  def index
    @skills = Skill.all
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
  end

  # GET /skills/new
  def new
    @skill = Skill.new
  end

  # GET /skills/1/edit
  def edit
  end

  # POST /skills
  # POST /skills.json
  def create
    @skill = current_user.skills.build(skill_params)

    respond_to do |format|
      if @skill.save
        format.html { redirect_to :back, notice: 'Skill was successfully created.' }
        format.json { render action: 'show', status: :created, location: @skill }
      else
        format.html { render action: 'new' }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skills/1
  # PATCH/PUT /skills/1.json
  def update
    respond_to do |format|
      if @skill.update(skill_params)
        format.html { redirect_to @skill, notice: 'Skill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy
    @skill.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    def set_notifications
      @notifications = Notification.all
      @open_notifications_count = @notifications.where(:notifiee => current_user, :read => false).count - @notifications.where(:notifiee => current_user, :notifier => current_user, :read => false).count - @notifications.where('created_at >= ?', Time.now).count 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      params.require(:skill).permit(:user_id, :prefered_area_id)
    end
end
