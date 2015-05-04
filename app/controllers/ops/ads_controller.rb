class Ops::AdsController < ApplicationController
  before_filter :enforce_auth
  before_filter :enforce_superuser
  before_action :set_ad, only: [:approve]
  
  def index
    @ads = Ad.all
  end

  # PATCH/PUT /ops/ads/1/approve
  # PATCH/PUT /ops/ads/1/approve.json
  def approve
    respond_to do |format|
      if @ad.update_as_approved_by(authed_user)
        format.html { redirect_to ops_ads_path, notice: 'Ad was successfully approved.' }
        format.json { render :show, status: :ok, location: ops_ads_path }
      else
        format.html { redirect_to edit_org_ad_path(@ad.org, @ad) }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_ad
    @ad = Ad.find(params[:id])
  end
end
