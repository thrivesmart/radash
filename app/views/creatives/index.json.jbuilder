json.array!(@creatives) do |creative|
  json.extract! creative, :id, :org_id, :asset_id, :title, :url, :postername, :posterid, :promoted_thingid, :locale, :attachment_type, :attachment_html, :approved_at, :approver_name
  json.url creative_url(creative, format: :json)
end
