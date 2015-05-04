class RedditProxyController < ApplicationController
  @@subreddits = {}
  def subreddits
    if @@subreddits.blank?
      logger.info "Picking up subreddits"
      @@subreddits = ActiveSupport::JSON.decode(Net::HTTP.get(URI.parse('http://s3.amazonaws.com/radash-cdn/subreddits.json')))
    end
    
    if params[:q].blank?
      @results = @@subreddits['subreddits'].map { |s| { value: s[0] } }
    else
      @results = []
    end
    
    respond_to do |format|
      format.json { render json: @results }
    end
  end
end
