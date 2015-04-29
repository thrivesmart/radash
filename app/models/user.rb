class User < ActiveRecord::Base
  has_many :reservations
  has_many :orgs, foreign_key: 'owner_id'
  has_many :memberships
  
  
  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9\-_]+\Z/ }
  # Only allow one account per Provider ID
  validates :redditid, presence: true, uniqueness: { case_sensitive: false }
  
  def to_param
    self.username
  end
  
  def self.oauth_provider_to_id_attr(provider_name)
    if provider_name == 'google_oauth2'
      return "googleid"
    else
      return "#{provider_name}id"
    end
  end
  
  def self.find_from_omniauth(omniauth_auth)
    # Look up the id of the user according to the provider name
    provider_name = oauth_provider_to_id_attr(omniauth_auth['provider'])
    existing_user = User.where(provider_name => omniauth_auth['uid']).first
    
    if !existing_user && !omniauth_auth['info']['name'].blank? # Try to find with email instead of id
      existing_user = User.where(username: omniauth_auth['info']['name']).first
    end
    
    return existing_user
  end
  
  def self.create_or_update_user_from_omniauth(omniauth_auth)
    existing_user = find_from_omniauth(omniauth_auth)

    if existing_user
      unless omniauth_auth['info']['email'].blank? && omniauth_auth['info']['image'].blank?
        # Always get a new image, and perhaps an email
        new_values = { picurl: omniauth_auth['info']['image'] }
        new_values[:email] = omniauth_auth['info']['email'] unless !existing_user.email.blank? || omniauth_auth['info']['email'].blank?
        
        existing_user.update_attributes(new_values)
      end
    else
      first_name = omniauth_auth['info']['name'].partition(" ").first.partition(" ").first
      potential_last_name = omniauth_auth['info']['name'].rpartition(" ").last
      
      values = {
        first_name:      first_name,
        middle_name:     omniauth_auth['info']['name'].partition(" ").first.partition(" ").last,
        last_name:       potential_last_name == first_name ? '' : potential_last_name,
        picurl:          omniauth_auth['info']['image']
      }

      values[oauth_provider_to_id_attr(omniauth_auth['provider']).to_sym] = omniauth_auth['uid']
      values[:email] = omniauth_auth['info']['email'] unless omniauth_auth['info']['email'].blank?
      values[:username] = omniauth_auth['info']['name'] unless omniauth_auth['info']['name'].blank?
      logger.error omniauth_auth.inspect
      existing_user = User.create!(values)
    end
    
    existing_user
  end
  
  # Allow users to connect multiple omni auth
  def update_and_connect_omniauth(omniauth_auth)
    existing_id_for_provider = self.send(User.oauth_provider_to_id_attr(omniauth_auth['provider']))
    
    if existing_id_for_provider.blank?
      new_values = { picurl: omniauth_auth['info']['image'] }
      new_values[User.oauth_provider_to_id_attr(omniauth_auth['provider']).to_sym] = omniauth_auth['uid']
      new_values[:email] = omniauth_auth['info']['email'] unless !self.email.blank? || omniauth_auth['info']['email'].blank?
    
      return update_attributes(new_values)
    end
    true
  end
  
  def full_name
    "#{self.first_name}#{self.middle_name.blank? ? '' : ' '+self.middle_name} #{self.last_name}"
  end
  
end
