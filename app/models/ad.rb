class Ad < ActiveRecord::Base
  BID_TYPES = { cpm: "CPM - Cost Per Thousand Impressions", cpc: "CPC - Cost Per Click", cpinsert: "CPInsert - Cost Per Insertion" }
  VALID_BID_TYPES = BID_TYPES.keys.map(&:to_s)
  
  OS = [ 'Android', 'OS X', 'Windows', 'Windows Phone', 'iOS', 'Linux', 'Chrome OS', 'Blackberry', 'Symbian' ]
  OS_VERSIONS = {
    'Android' => ['2.0+', '2.1+', '2.2+', '2.3+', '3.0+', '3.1+', '3.2+', '4.0+', '4.1+', '4.2+', '4.3+', '4.4+', '5.0+'], 
    'OS X' => ['10.0+', '10.1+', '10.2+', '10.3+', '10.4+', '10.5+', '10.6+', '10.7+', '10.8+', '10.9+', '10.10+'], 
    'Windows' => ['XP+', 'Vista+', '7+', '8.0+', '8.1+', '10+'],
    'Windows Phone' => ['7+', '7.5+', '7.8+', '8.0+', '8.1+', '10+'],
    'iOS' => ['6+', '7+', '8+'],
    'Linux' => ['Ubuntu', 'Debian', 'Fedora', 'Mint'], 
    'Chrome OS' => ['beta', 'stable'],
    'Blackberry' => ['6.0+', '7.0+', '7.1', '10.0+', '10.1+', '10.2+', '10.3+'],
    'Symbian' => ['9.3+', '9.4+', '9.5+', '10.0+', '10.1+']
  }
  DEVICES = [ 'Desktop/Laptop', 'Tablet', 'Smartphone', 'iPhone', 'iPad', 'iPod', 'Kindle Fire' ]
  
  belongs_to :org
  belongs_to :creative
  has_and_belongs_to_many :campaigns
  
  validates :org, presence: true
  validates :creative, presence: true
  validates :bid_type, presence: true, inclusion: { in: VALID_BID_TYPES, message: "%{value} bid type is not valid." }
  validates :bid_in_cents, presence: true
  
  serialize :locations, JSON
  serialize :devices, JSON
  serialize :os, JSON
  serialize :os_versions, JSON
  serialize :subreddits, JSON
  serialize :interests, JSON
  serialize :placements, JSON
  
  def title
    "#{self.creative.title} @ $#{self.bid_in_cents / 100.00} #{self.bid_type}"
  end
end
