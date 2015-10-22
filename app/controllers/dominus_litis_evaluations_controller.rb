class DominusLitisEvaluationsController < ApplicationController
  before_action :set_dominus_litis_evaluation, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :subscribed_user#, :only => [:show, :new, :edit]

  # GET /dominus_litis_evaluations
  # GET /dominus_litis_evaluations.json
  def index
    @dominus_litis_evaluations = DominusLitisEvaluation.all
  end

  # GET /dominus_litis_evaluations/1
  # GET /dominus_litis_evaluations/1.json
  def show
  end

  # GET /dominus_litis_evaluations/new
  def new
    @dominus_litis_evaluation = DominusLitisEvaluation.new
  end

  # GET /dominus_litis_evaluations/1/edit
  def edit
  end

  # POST /dominus_litis_evaluations
  # POST /dominus_litis_evaluations.json
  def create
    @dominus_litis_evaluation = current_user.dominus_litis_evaluations.build(dominus_litis_evaluation_params)

    respond_to do |format|
      if @dominus_litis_evaluation.save
        format.html { redirect_to :back, notice: 'Dominus litis evaluation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dominus_litis_evaluation }
      else
        format.html { render action: 'new' }
        format.json { render json: @dominus_litis_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dominus_litis_evaluations/1
  # PATCH/PUT /dominus_litis_evaluations/1.json
  def update
    respond_to do |format|
      if @dominus_litis_evaluation.update(dominus_litis_evaluation_params)
        format.html { redirect_to :back, notice: 'Dominus litis evaluation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dominus_litis_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dominus_litis_evaluations/1
  # DELETE /dominus_litis_evaluations/1.json
  def destroy
    @dominus_litis_evaluation.destroy
    respond_to do |format|
      format.html { redirect_to dominus_litis_evaluations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dominus_litis_evaluation
      @dominus_litis_evaluation = DominusLitisEvaluation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dominus_litis_evaluation_params
      params.require(:dominus_litis_evaluation).permit(:user_id, :court_id, :evaluation, :comment)
    end
end
