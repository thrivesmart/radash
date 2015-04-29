class AdsController < ApplicationController
  before_action :set_org
  before_filter :enforce_org_administrator
  before_action :set_ad, only: [:show, :edit, :update, :destroy]

  # GET /ads
  # GET /ads.json
  def index
    @ads = @org.ads
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @ad = @org.ads.build
  end

  # GET /ads/1/edit
  def edit
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = @org.ads.build(ad_params)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to [@ad.org, @ad], notice: 'Ad was successfully created.' }
        format.json { render :show, status: :created, location: [@ad.org, @ad] }
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to [@ad.org, @ad], notice: 'Ad was successfully updated.' }
        format.json { render :show, status: :ok, location: [@ad.org, @ad] }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to org_ads_url(@ad.org), notice: 'Ad was successfully destroyed.' }
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
  def set_ad
    @ad = @org.ads.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ad_params
    params.require(:ad).permit(:creative_id, :bid_type, :bid_in_cents, :locations, :devices, :os, :os_versions, :subreddits, :interests, :placements)
  end
end
