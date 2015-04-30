class AdsCampaignsController < ApplicationController
  before_action :set_org
  before_filter :enforce_org_administrator
  before_action :set_campaign
  before_action :set_ad, only: [:destroy]
  
  def new
    @ads_campaigns = @campaign
  end
  

  # POST /ads_campaigns
  # POST /ads_campaigns.json
  def create
    @ad = @org.ads.find(params[:ads_campaigns][:ad_id])
    @campaign.ads << @ad

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to [@campaign.org, @campaign], notice: 'Ad was successfully added to campaign.' }
        format.json { render :show, status: :created, location: [@campaign.org, @campaign] }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads_campaigns/1
  # DELETE /ads_campaigns/1.json
  def destroy
    @campaign.ads.delete(@ad)
    respond_to do |format|
      format.html { redirect_to [@campaign.org, @campaign], notice: 'Ad was successfully removed from campaign.' }
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
    @campaign = @org.campaigns.find(params[:campaign_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_ad
    @ad = @org.ads.find(params[:id])
  end
end
