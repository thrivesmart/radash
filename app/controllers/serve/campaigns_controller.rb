class Serve::CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.where(paused_at: nil)
  end
end
