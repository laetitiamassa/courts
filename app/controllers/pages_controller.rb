class PagesController < ApplicationController
  before_action :set_notifications

  def home
  	
  end

  def about
  end

  def legal
  end

  def welcome
    
  	@courts = Court.all
    @court = current_user.courts.build if current_user
    @bars = Court.bars

    @questions = Question.all
    @question = current_user.questions.build if current_user

    @response = current_user.responses.build if current_user
  end

  private

  def set_notifications
      @notifications = Notification.all
      @open_notifications_count = @notifications.where(:notifiee => current_user, :read => false).count - @notifications.where(:notifiee => current_user, :notifier => current_user, :read => false).count - @notifications.where('created_at >= ?', Time.now).count 
    end
end
