class Ad < ActiveRecord::Base
  BID_TYPES = { cpm: "CPM - Cost Per Thousand Impressions", cpc: "CPC - Cost Per Click", cpinsert: "CPInsert - Cost Per Insertion" }
  VALID_BID_TYPES = BID_TYPES.keys.map(&:to_s)
  
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
