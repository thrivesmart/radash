class Org < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :memberships, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :creatives, dependent: :destroy
  has_many :ads, dependent: :destroy
  has_many :campaigns, dependent: :destroy
  
  before_validation :autofill_permalink_if_blank
  
  validates :permalink, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9\-_]+\Z/ }
  
  def autofill_permalink_if_blank
    return true unless self.permalink.blank? # Bypass if permalink is already set
    self.permalink = AutoPermalink::cleaned_deduped_permalink(self.class, self.name)
  end

  def to_param
    self.permalink
  end
end
