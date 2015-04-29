class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :auth_hash
  helper_method :authed_user
  
  helper_method :authed_administrator
  # before_filter :enforce_auth ## Use this in your own controllers hidden behind auths.
  # before_filter :enforce_superuser ## Use this in your own controllers hidden behind auths.
  
  protected
  
  def enforce_auth
    authed_user
    
    if authed_user.blank?
      session[:after_auth_url] = request.url
      session[:current_user] = nil
      redirect_to '/sessions/new'
      return false
    end
    return true
  end
  
  def enforce_superuser    
    if !enforce_auth
      render :text => "Sorry, you need to be logged in to see this.", :status => :unauthorized
      return false
    end
    
    if !authed_user || !authed_user.superuser 
      render :text => "Sorry, you aren't authorized to access this page.", :status => :unauthorized
      return false
    end
    return true
  end

  def set_authed_org_membership
    return nil if @org.nil? && params[:org_id].nil? # org doesn't exist, so ignore
    return nil if !authed_user # not logged in
    
    org = @org || Org.find_by_permalink(params[:org_id])
    return nil unless org
    
    @org_membership = org.memberships.where(user_id: authed_user.id).first
    return nil unless @org_membership
    return @org_membership
  end
  
  def set_authed_membership
    @authed_membership ||= begin
      set_authed_org_membership
    end
  end

  def enforce_org_administrator
    if !authed_administrator
      render :text => "Sorry, you aren't an administrator here.", :status => :unauthorized
      return false
    else
      return true
    end
  end
  
  def auth_hash
    request.env['omniauth.auth']
  end

  def authed_administrator
    @authed_administrator ||= begin
      membership = set_authed_membership
      if authed_user && (authed_user.superuser || (membership && membership.administration?))
        true
      else
        false
      end
    end
  end
  
  def authed_user
    @authed_user ||= begin
      if !session[:current_user].blank?
        User.find_by_id(session[:current_user].to_s.to_i)
      elsif auth_hash.blank?
        nil
      else
        existing_user = User.find_from_omniauth(auth_hash)
        unless existing_user
          existing_user = User.create_or_update_user_from_omniauth(auth_hash)
        end
        existing_user
      end
    end
  end
  
end
