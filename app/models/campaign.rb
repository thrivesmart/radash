class Campaign < ActiveRecord::Base
  GOAL_TYPES = { click_roi: "% ROI from Click-Thru Conversions", view_and_click_roi: "% ROI from Click-Thru and View-Thru Conversions", view_reach: "View Reach: Total number of different people viewed.", engagement_reach: "Engagement Reach: Total number of different people commented and voted." }
  VALID_GOAL_TYPES = GOAL_TYPES.keys.map(&:to_s)
  
  belongs_to :org
  has_and_belongs_to_many :ads
  
  validates :org, presence: true
  validates :total_budget_in_cents, presence: true
  validates :goal_type, inclusion: { in: VALID_GOAL_TYPES, message: "%{value} bid type is not valid.", allow_blank: true }
  
  serialize :flights, JSON
end
