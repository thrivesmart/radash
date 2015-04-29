class Creative < ActiveRecord::Base
  belongs_to :org
  belongs_to :asset
  
  validates :org, presence: true
end
