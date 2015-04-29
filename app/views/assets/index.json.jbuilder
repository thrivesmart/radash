json.array!(@assets) do |asset|
  json.extract! asset, :id, :org_id, :name, :file, :html, :width, :height
  json.url asset_url(asset, format: :json)
end
