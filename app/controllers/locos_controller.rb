class LocosController < ApplicationController
  before_action :set_loco, only: [:show, :edit, :update, :destroy]

  # GET /locos
  # GET /locos.json
  def index
    @locos = Loco.all
  end

  # GET /locos/1
  # GET /locos/1.json
  def show
  end

  # GET /locos/new
  def new
    @loco = Loco.new
  end

  # GET /locos/1/edit
  def edit
  end

  # POST /locos
  # POST /locos.json
  def create
    @loco = Loco.new(loco_params)

    respond_to do |format|
      if @loco.save
        format.html { redirect_to :back, notice: 'Loco was successfully created.' }
        format.json { render action: 'show', status: :created, location: @loco }
      else
        format.html { render action: 'new' }
        format.json { render json: @loco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locos/1
  # PATCH/PUT /locos/1.json
  def update
    respond_to do |format|
      if @loco.update(loco_params)
        format.html { redirect_to @loco, notice: 'Loco was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @loco.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locos/1
  # DELETE /locos/1.json
  def destroy
    @loco.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loco
      @loco = Loco.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loco_params
      params.require(:loco).permit(:user_id, :court_id)
    end
end
