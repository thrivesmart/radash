class Ad < ActiveRecord::Base
  belongs_to :org
  belongs_to :creative
end
