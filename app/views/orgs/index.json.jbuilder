json.array!(@orgs) do |org|
  json.extract! org, :id, :name, :permalink, :email, :phone, :url, :owner_id, :street_address1, :street_address2, :city, :state_province_region, :zip_postal_code, :country_code, :timezone, :currency_code
  json.url org_url(org, format: :json)
end
