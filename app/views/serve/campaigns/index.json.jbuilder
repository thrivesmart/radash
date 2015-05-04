json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :org_id, :name, :total_budget_in_cents, :goal_value, :goal_type, :flights, :paused_at
  json.ads campaign.ads.where(paused_at: nil).where('approved_at is not null') do |ad|
    json.extract! ad, :id, :org_id, :bid_type, :bid_in_cents, :locations, :devices, :os, :os_versions, :subreddits, :interests, :placements, :paused_at, :approved_at, :approver_name, :created_at, :updated_at
    
    json.creative do
      json.extract! ad.creative, :id, :org_id, :title, :url, :postername, :posterid, :promoted_thingid, :locale, :attachment_type, :attachment_html, :approved_at, :approver_name, :created_at, :updated_at
      json.asset do
        json.extract! ad.creative.asset, :id, :org_id, :file, :name, :html, :width, :height, :created_at, :updated_at 
      end
    end
  end
  json.url org_campaign_url(campaign.org, campaign, format: :json)
end
