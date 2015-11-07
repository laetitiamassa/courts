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
    
  	@courts = Court.all
    @court = current_user.courts.build if current_user
    @bars = Court.bars

    @questions = Question.all
    @question = current_user.questions.build if current_user

    @response = current_user.responses.build if current_user
  end

  def account
  end

  def rewards
  end


end
