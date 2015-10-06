class DocumentationsController < ApplicationController
  before_action :set_documentation, only: [:show, :edit, :update, :destroy]

  # GET /documentations
  # GET /documentations.json
  def index
    @documentations = Documentation.all
  end

  # GET /documentations/1
  # GET /documentations/1.json
  def show
  end

  # GET /documentations/new
  def new
    @documentation = Documentation.new
  end

  # GET /documentations/1/edit
  def edit
  end

  # POST /documentations
  # POST /documentations.json
  def create
    @documentation = current_user.documentations.build(documentation_params)

    respond_to do |format|
      if @documentation.save
        format.html { redirect_to :back, notice: 'Documentation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @documentation }
      else
        format.html { render action: 'new' }
        format.json { render json: @documentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documentations/1
  # PATCH/PUT /documentations/1.json
  def update
    respond_to do |format|
      if @documentation.update(documentation_params)
        format.html { redirect_to @documentation, notice: 'Documentation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @documentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentations/1
  # DELETE /documentations/1.json
  def destroy
    @documentation.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documentation
      @documentation = Documentation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def documentation_params
      params.require(:documentation).permit(:name, :user_id, :court_id, :document)
    end
end
