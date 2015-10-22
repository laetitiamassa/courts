class PrivateDocumentationsController < ApplicationController
  before_action :set_private_documentation, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :subscribed_user#, :only => [:show, :new, :edit]

  # GET /private_documentations
  # GET /private_documentations.json
  def index
    @private_documentations = PrivateDocumentation.all
  end

  # GET /private_documentations/1
  # GET /private_documentations/1.json
  def show
  end

  # GET /private_documentations/new
  def new
    @private_documentation = PrivateDocumentation.new
  end

  # GET /private_documentations/1/edit
  def edit
  end

  # POST /private_documentations
  # POST /private_documentations.json
  def create
    @private_documentation = current_user.private_documentations.build(private_documentation_params)

    respond_to do |format|
      if @private_documentation.save
        format.html { redirect_to :back, notice: 'Private documentation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @private_documentation }
      else
        format.html { render action: 'new' }
        format.json { render json: @private_documentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /private_documentations/1
  # PATCH/PUT /private_documentations/1.json
  def update
    respond_to do |format|
      if @private_documentation.update(private_documentation_params)
        format.html { redirect_to @private_documentation, notice: 'Private documentation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @private_documentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /private_documentations/1
  # DELETE /private_documentations/1.json
  def destroy
    @private_documentation.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_private_documentation
      @private_documentation = PrivateDocumentation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def private_documentation_params
      params.require(:private_documentation).permit(:name, :user_id, :loco_id, :document)
    end
end
