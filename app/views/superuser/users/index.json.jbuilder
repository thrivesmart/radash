json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :first_name, :middle_name, :last_name, :phone, :picurl, :redditid, :superuser
  json.url user_url(user, format: :json)
end
