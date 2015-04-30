json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :org_id, :name, :total_budget_in_cents, :goal_value, :goal_type, :flights, :paused_at
  json.url campaign_url(campaign, format: :json)
end
