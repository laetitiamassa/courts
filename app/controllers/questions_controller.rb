class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :subscribed_user, :only => [:show, :new, :edit]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
    @question = current_user.questions.build if current_user
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @questions = Question.all
    @question = Question.find(params[:id])

    @answer = current_user.answers.build if current_user
    @answers = @question.answers.order("updated_at DESC")
  end

  # GET /questions/new
  def new
    @question = current_user.questions.build if current_user
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = current_user.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def correct_user
      @question = current_user.questions.find_by(id: params[:id])
      redirect_to questions_path, notice: t("courts.forbidden_modification") if @question.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:subject, :description, :user_id)
    end
end
