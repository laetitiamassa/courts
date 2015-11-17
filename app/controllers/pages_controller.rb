class PagesController < ApplicationController
  # Render mobile or desktop depending on User-Agent for these actions.
  before_filter :check_for_mobile #, :only => [:new, :edit]

  # Always render mobile versions for these, regardless of User-Agent.
  #before_filter :prepare_for_mobile, :only => :show
  
  before_filter :authenticate_user!, :only => [:account, :rewards]



  def home
  	
  end

  def about
  end

  def legal
  end

  def welcome
    @users = User.all
  	@courts = Court.all
    @court = current_user.courts.build if current_user
    @bars = Court.bars

    @response = current_user.responses.build if current_user

    @external_courts = Court.where(:is_external => true)
    @confirmation = current_user.confirmations.build if current_user

    # @questions = Question.all
    # @question = current_user.questions.build if current_user

    
  end

  def user_evaluations_to_give
    @courts = Court.all
    @court = current_user.courts.build if current_user
    @bars = Court.bars
  end

  def user_evaluations_received
    @courts = Court.all
    @court = current_user.courts.build if current_user
    @bars = Court.bars
  end

  def user_evaluations_given
    @courts = Court.all
    @court = current_user.courts.build if current_user
    @bars = Court.bars
  end

  def user_current_courts
    @courts = Court.all
    @court = current_user.courts.build if current_user
    @bars = Court.bars
  end

  def user_past_courts
    @courts = Court.all
    @court = current_user.courts.build if current_user
    @bars = Court.bars
  end

  def user_current_conversations
    @courts = Court.all
    @court = current_user.courts.build if current_user
    @bars = Court.bars
  end

  def user_past_conversations
    @courts = Court.all
    @court = current_user.courts.build if current_user
    @bars = Court.bars
  end

  def account
  end

  def rewards
  end


end
