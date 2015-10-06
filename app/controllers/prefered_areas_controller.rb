class PreferedAreasController < ApplicationController
  before_action :set_prefered_area, only: [:show, :edit, :update, :destroy]

  # GET /prefered_areas
  # GET /prefered_areas.json
  def index
    @prefered_areas = PreferedArea.all
    @skill = current_user.skills.new
  end

  # GET /prefered_areas/1
  # GET /prefered_areas/1.json
  def show
  end

  # GET /prefered_areas/new
  def new
    @prefered_area = PreferedArea.new
  end

  # GET /prefered_areas/1/edit
  def edit
  end

  # POST /prefered_areas
  # POST /prefered_areas.json
  def create
    @prefered_area = PreferedArea.new(prefered_area_params)

    respond_to do |format|
      if @prefered_area.save
        format.html { redirect_to @prefered_area, notice: 'Prefered area was successfully created.' }
        format.json { render action: 'show', status: :created, location: @prefered_area }
      else
        format.html { render action: 'new' }
        format.json { render json: @prefered_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prefered_areas/1
  # PATCH/PUT /prefered_areas/1.json
  def update
    respond_to do |format|
      if @prefered_area.update(prefered_area_params)
        format.html { redirect_to @prefered_area, notice: 'Prefered area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @prefered_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prefered_areas/1
  # DELETE /prefered_areas/1.json
  def destroy
    @prefered_area.destroy
    respond_to do |format|
      format.html { redirect_to prefered_areas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prefered_area
      @prefered_area = PreferedArea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prefered_area_params
      params.require(:prefered_area).permit(:name)
    end
end
