class PagesController < ApplicationController
  def home
  	
  end

  def about
  end

  def legal
  end

  def welcome
  	@courts = Court.active.order(:date)
    @court = current_user.courts.build if current_user
    @bars = Court.bars

    @questions = Question.all
    @question = current_user.questions.build if current_user
  end
end
