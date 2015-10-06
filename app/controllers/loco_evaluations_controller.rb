class LocoEvaluationsController < ApplicationController
  before_action :set_loco_evaluation, only: [:show, :edit, :update, :destroy]

  # GET /loco_evaluations
  # GET /loco_evaluations.json
  def index
    @loco_evaluations = LocoEvaluation.all
  end

  # GET /loco_evaluations/1
  # GET /loco_evaluations/1.json
  def show
  end

  # GET /loco_evaluations/new
  def new
    @loco_evaluation = LocoEvaluation.new
  end

  # GET /loco_evaluations/1/edit
  def edit
  end

  # POST /loco_evaluations
  # POST /loco_evaluations.json
  def create
    @loco_evaluation = current_user.loco_evaluations.build(loco_evaluation_params)

    respond_to do |format|
      if @loco_evaluation.save
        format.html { redirect_to :back, notice: 'Loco evaluation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @loco_evaluation }
      else
        format.html { render action: 'new' }
        format.json { render json: @loco_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loco_evaluations/1
  # PATCH/PUT /loco_evaluations/1.json
  def update
    @loco_evaluation = LocoEvaluation.find(params[:id])
    respond_to do |format|
      if @loco_evaluation.update(loco_evaluation_params)
        format.html { redirect_to :back, notice: 'Loco evaluation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @loco_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loco_evaluations/1
  # DELETE /loco_evaluations/1.json
  def destroy
    @loco_evaluation.destroy
    respond_to do |format|
      format.html { redirect_to loco_evaluations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loco_evaluation
      @loco_evaluation = LocoEvaluation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loco_evaluation_params
      params.require(:loco_evaluation).permit(:user_id, :court_id, :evaluation, :comment)
    end
end
