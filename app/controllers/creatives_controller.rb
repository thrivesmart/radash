class CreativesController < ApplicationController
  before_action :set_org
  before_filter :enforce_org_administrator
  before_action :set_creative, only: [:show, :edit, :update, :destroy]

  # GET /creatives
  # GET /creatives.json
  def index
    @creatives = @org.creatives
  end

  # GET /creatives/1
  # GET /creatives/1.json
  def show
  end

  # GET /creatives/new
  def new
    @creative = @org.creatives.build(locale: 'en-US')
  end

  # GET /creatives/1/edit
  def edit
  end

  # POST /creatives
  # POST /creatives.json
  def create
    @creative = @org.creatives.build(creative_params)

    respond_to do |format|
      if @creative.save
        format.html { redirect_to [@creative.org, @creative], notice: 'Creative was successfully created.' }
        format.json { render :show, status: :created, location: [@creative.org, @creative] }
      else
        format.html { render :new }
        format.json { render json: @creative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /creatives/1
  # PATCH/PUT /creatives/1.json
  def update
    respond_to do |format|
      if @creative.update(creative_params)
        format.html { redirect_to [@creative.org, @creative], notice: 'Creative was successfully updated.' }
        format.json { render :show, status: :ok, location: [@creative.org, @creative] }
      else
        format.html { render :edit }
        format.json { render json: @creative.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /creatives/1
  # DELETE /creatives/1.json
  def destroy
    @creative.destroy
    respond_to do |format|
      format.html { redirect_to org_creatives_url(@creative.org), notice: 'Creative was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_org
      @org = Org.find_by_permalink(params[:org_id])
      raise ActiveRecord::RecordNotFound unless @org
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_creative
      @creative = @org.creatives.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def creative_params
      params.require(:creative).permit(:asset_id, :title, :url, :postername, :posterid, :promoted_thingid, :locale, :attachment_type, :attachment_html)
    end
end
