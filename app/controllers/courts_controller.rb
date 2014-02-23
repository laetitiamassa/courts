class CourtsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  before_action :set_court, only: [:show, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]

  # GET /courts
  # GET /courts.json
  def index
    @courts = Court.active.order(:date)
    @court = current_user.courts.build if current_user
    @bars = Court.bars
  end

  # GET /courts/1
  # GET /courts/1.json
  def show
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
        format.html { redirect_to root_path, notice: 'Votre demande a bien ete creee.' }
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
        format.html { redirect_to @court, notice: 'Votre demande est modifiee.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_court
      @court = Court.find(params[:id])
    end

    def correct_user
      @court = current_user.courts.find_by(id: params[:id])
      redirect_to courts_path, notice: "Vous ne pouvez modifier cette demande" if @court.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def court_params
      params.require(:court).permit(:performance, :jurisdiction, :date, :bar, :have_found)
    end
end
