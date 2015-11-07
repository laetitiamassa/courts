class PreferedAreasController < ApplicationController
  # Render mobile or desktop depending on User-Agent for these actions.
  before_filter :check_for_mobile #, :only => [:new, :edit]

  # Always render mobile versions for these, regardless of User-Agent.
  #before_filter :prepare_for_mobile, :only => :show
  
  before_action :set_prefered_area, only: [:show, :edit, :update, :destroy]
  before_action :set_notifications
  before_filter :authenticate_user!
  before_action :subscribed_user#, :only => [:show, :new, :edit]

  # GET /prefered_areas
  # GET /prefered_areas.json
  def index
    @prefered_areas = PreferedArea.all
    @skill = current_user.skills.new
  end

  # GET /prefered_areas/1
  # GET /prefered_areas/1.json
  def show
  end

  # GET /prefered_areas/new
  def new
    @prefered_area = PreferedArea.new
  end

  # GET /prefered_areas/1/edit
  def edit
  end

  # POST /prefered_areas
  # POST /prefered_areas.json
  def create
    @prefered_area = PreferedArea.new(prefered_area_params)

    respond_to do |format|
      if @prefered_area.save
        format.html { redirect_to @prefered_area, notice: 'Prefered area was successfully created.' }
        format.json { render action: 'show', status: :created, location: @prefered_area }
      else
        format.html { render action: 'new' }
        format.json { render json: @prefered_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prefered_areas/1
  # PATCH/PUT /prefered_areas/1.json
  def update
    respond_to do |format|
      if @prefered_area.update(prefered_area_params)
        format.html { redirect_to @prefered_area, notice: 'Prefered area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @prefered_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prefered_areas/1
  # DELETE /prefered_areas/1.json
  def destroy
    @prefered_area.destroy
    respond_to do |format|
      format.html { redirect_to prefered_areas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prefered_area
      @prefered_area = PreferedArea.find(params[:id])
    end

    def set_notifications
      @notifications = Notification.all
      @open_notifications_count = @notifications.where(:notifiee => current_user, :read => false).count - @notifications.where(:notifiee => current_user, :notifier => current_user, :read => false).count - @notifications.where('created_at >= ?', Time.now).count 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prefered_area_params
      params.require(:prefered_area).permit(:name)
    end
end
