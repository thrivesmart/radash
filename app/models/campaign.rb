class Campaign < ActiveRecord::Base
  belongs_to :org
  has_and_belongs_to_many :ads
  
  validates :org, presence: true
  validates :total_budget_in_cents, presence: true
end
