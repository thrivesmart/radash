json.array!(@ads) do |ad|
  json.extract! ad, :id, :org_id, :creative_id, :bid_type, :bid_in_cents, :locations, :devices, :os, :os_versions, :subreddits, :interests, :placements, :paused_at, :approved_at, :approver_name
  json.url ad_url(ad, format: :json)
end
