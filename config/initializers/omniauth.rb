Rails.application.config.middleware.use OmniAuth::Builder do
  provider :reddit, ENV['REDDIT_KEY'], ENV['REDDIT_SECRET'], scope: 'identity,account,read,mysubreddits'
end

OmniAuth.config.logger = Rails.logger
