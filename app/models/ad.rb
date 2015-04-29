class Ad < ActiveRecord::Base
  belongs_to :org
  belongs_to :creative
  has_and_belongs_to_many :campaigns
  
  validates :org, presence: true
  validates :creative, presence: true
  validates :bid_type, presence: true
  validates :bid_in_cents, presence: true
end
