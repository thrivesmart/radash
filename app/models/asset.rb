class Asset < ActiveRecord::Base
  belongs_to :org
  
  validates :org, presence: true
end
