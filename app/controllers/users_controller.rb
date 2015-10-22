class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_notifications
  before_action :subscribed_user, :only => [:show]
  
  def show
  	@user = User.find(params[:id])
    @user_courts = @user.courts.order("date DESC")
    @courts = Court.all
  end

  def edit
  	@user = current_user
    @bars = User.bars
  end

  def edit_coordonnees
    @user = current_user
    @bars = User.bars
  end

  def edit_activity
    @user = current_user
    @bars = User.bars
  end

  def update
  	@user = User.find(params[:id])
    @bars = User.bars
    if @user.update(user_params)
      redirect_to @user, notice: t("users.well_modified") 
    else
      render action: 'edit', notice: t("users.error")
    end
  end

  private

  def set_notifications
      @notifications = Notification.all
      @open_notifications_count = @notifications.where(:notifiee => current_user, :read => false).count - @notifications.where(:notifiee => current_user, :notifier => current_user, :read => false).count - @notifications.where('created_at >= ?', Time.now).count 
    end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :bar, 
                                  :street, :street_number, :city, :zipcode, 
                                  :telephone, :fax, :mobile, :website, :facebook, :twitter, :linkedin,
                                  :dominus_litis, :loco, :subscribed, :extended_trial, :extended_trial_end_date, 
                                  :presentation, :avatar,
                                  :plan, :plan_start_date, :plan_end_date, :subscription_start_date, :subscription_id)
  end
end
