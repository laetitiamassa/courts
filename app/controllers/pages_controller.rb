class PagesController < ApplicationController


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
