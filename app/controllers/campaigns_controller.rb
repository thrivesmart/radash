class CampaignsController < ApplicationController
  PERFORMANCE_HOST = "http://rads.herokuapp.com"
  
  before_action :set_org
  before_filter :enforce_org_administrator
  before_action :set_campaign, only: [:show, :performance, :edit, :update, :destroy]

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

  # GET /campaigns/1/performance.json?aid= | spend=true  
  def performance
    @result = ""
    if !params[:spend].blank?
      @result = ActiveSupport::JSON.decode(Net::HTTP.get(URI.parse("#{PERFORMANCE_HOST}/reports/campaign-spend.json?cid=#{@campaign.id}")))
    else
      @result = ActiveSupport::JSON.decode(Net::HTTP.get(URI.parse("#{PERFORMANCE_HOST}/reports/campaign-ad-performance.json?cid=#{@campaign.id}&aid=#{params[:aid]}")))
    end
    
    respond_to do |format|
      format.json { render json: @result }
    end
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    fix_flights_input_param
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
    fix_flights_input_param
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
    params.require(:campaign).permit(:total_budget_in_cents, :name, :goal_value, :goal_type, {flights: [ [:starts_at, :ends_at] ]})
  end
  
  # Change incoming form format to parsed dates
  def fix_flights_input_param
    if params[:campaign] && !params[:campaign][:flights].blank? && params[:campaign][:flights].respond_to?(:keys)
      parsed_flights = []
      params[:campaign][:flights].keys.each do |key|
        parsed_flights << { 
          starts_at:  ActiveSupport::TimeZone[params[:campaign][:flights][key]['starts_at']['timezone']].parse("#{params[:campaign][:flights][key]['starts_at']['date']} #{params[:campaign][:flights][key]['starts_at']['time']}"),
          ends_at: ActiveSupport::TimeZone[params[:campaign][:flights][key]['ends_at']['timezone']].parse("#{params[:campaign][:flights][key]['ends_at']['date']} #{params[:campaign][:flights][key]['ends_at']['time']}")
        }
      end
      params[:campaign][:flights] = parsed_flights
    end
  end
end
