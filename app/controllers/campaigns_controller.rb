class CampaignsController < ApplicationController
  before_action :set_org
  before_filter :enforce_org_administrator
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = @org.campaigns
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
    @campaign = @org.campaigns.build
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = @org.campaigns.build(campaign_params)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to [@campaign.org, @campaign], notice: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: [@campaign.org, @campaign] }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to [@campaign.org, @campaign], notice: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: [@campaign.org, @campaign] }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to org_campaigns_url(@campaign.org), notice: 'Campaign was successfully destroyed.' }
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
  def set_campaign
    @campaign = @org.campaigns.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def campaign_params
    params.require(:campaign).permit(:total_budget_in_cents, :name, :goal_value, :goal_type, :flights)
  end
end
