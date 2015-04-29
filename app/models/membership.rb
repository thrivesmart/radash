class Membership < ActiveRecord::Base
  PRIVILEGE_CODES = { administration: 'administration' }
  VALID_PRIVILEGES = PRIVILEGE_CODES.values
  
  belongs_to :org
  belongs_to :user
  
  attr_accessor :user_via_username # Allow membership to be added by email.
  
  validates :org_id, uniqueness: { scope: :user_id }
  validates :user, presence: { message: '- no user account found with that email.  Please have your friend login for free, first!' }
  validates :privileges, presence: true, inclusion: { in: VALID_PRIVILEGES, message: "%{value} setting is not valid." }
  
  before_validation :set_user_via_username
  
  
  def set_user_via_username
    return true unless self.user.nil?
    self.user = User.find_by_username(self.user_via_username)
  end
  
  # Can admin everything in this org
  def administration?
    self.privileges == PRIVILEGE_CODES[:administration]
  end
end
