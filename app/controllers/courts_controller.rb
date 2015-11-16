class CourtsController < ApplicationController
  # Render mobile or desktop depending on User-Agent for these actions.
  before_filter :check_for_mobile #, :only => [:new, :edit]

  # Always render mobile versions for these, regardless of User-Agent.
  #before_filter :prepare_for_mobile, :only => :show

  before_action :set_notifications
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :subscribed_user, :except => [:show]
  before_action :set_court, only: [:show, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit]

  # GET /courts
  # GET /courts.json
  def index
    @courts = Court.all
    @court = current_user.courts.build if current_user
    @response = current_user.responses.build if current_user
    @bars = Court.bars
  end

  # GET /courts/1
  # GET /courts/1.json
  def show
    @confirmation = current_user.confirmations.build if current_user

    @response = current_user.responses.build if current_user

    @loco = Loco.new
    @locos = Loco.all

    @comment = current_user.comments.build if current_user
    @comments = Comment.order("updated_at DESC")

    @documentation = current_user.documentations.build if current_user
    @private_documentation = current_user.private_documentations.build if current_user

    @dominus_litis = @court.user
    @loco_lawyer = @court.locos.last.user if @court.locos.any?

    @loco_evaluation = current_user.loco_evaluations.build if current_user
    @dominus_litis_evaluation = current_user.dominus_litis_evaluations.build if current_user
  end

  # GET /courts/new
  def new
    @court = current_user.courts.build
    @bars = Court.bars
  end

  # GET /courts/1/edit
  def edit
    @bars = Court.bars
  end

  # POST /courts
  # POST /courts.json
  def create
    @court = current_user.courts.build(court_params)

    respond_to do |format|
      if @court.save
      
          #send potential loco in the concerned bar a notification
          UserMailer.new_court_in_my_bar(@court, users_in_bar).deliver if has_users_in_bar? && !@court.to_confirm
          UserMailer.after_court_creation(@court, @court.user).deliver if has_users_in_bar? && !@court.to_confirm
      
          #envoyer notif à dl lui demandant s'il veut se faire remplacer pour cette audience
          UserMailer.do_you_need_a_loco(@court, @court.user).deliver #if @court.to_confirm
       

        format.html { redirect_to root_path, notice: t("courts.well_created") }
        format.json { render action: 'show', status: :created, location: @court }
      else
        format.html { render action: 'new' }
        format.json { render json: @court.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courts/1
  # PATCH/PUT /courts/1.json
  def update
    respond_to do |format|
      if @court.update(court_params)
        format.html { redirect_to @court, notice: t("courts.well_modified") }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @court.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courts/1
  # DELETE /courts/1.json
  def destroy
    @court.destroy
    respond_to do |format|
      format.html { redirect_to courts_url }
      format.json { head :no_content }
    end
  end

  #users_in_bar
    def users_in_bar
      User.where(:bar => @court.bar) #.where.not(id: current_user) 
    end 

    def has_users_in_bar?
      users_in_bar.any?
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_court
      @court = Court.find(params[:id])
    end

    def correct_user
      @court = current_user.courts.find_by(id: params[:id])
      redirect_to root_path, notice: t("courts.forbidden_modification") if @court.nil?
    end

    def set_notifications
      @notifications = Notification.all
      @open_notifications_count = @notifications.where(:notifiee => current_user, :read => false).count - @notifications.where(:notifiee => current_user, :notifier => current_user, :read => false).count - @notifications.where('created_at >= ?', Time.now).count 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def court_params
      params.require(:court).permit(:user_id, :performance, :jurisdiction, :date, :bar, :have_found, :details, 
                                    :is_external, :external_requester_first_name, :external_requester_last_name, :external_requester_email, :internalized_at,
                                    :to_confirm, :confirmed, :infirmed, :confirmed_at, :infirmed_at)
    end

end
