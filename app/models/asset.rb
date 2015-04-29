class Asset < ActiveRecord::Base
  belongs_to :org

  has_attached_file :file, storage: :s3, s3_credentials: { bucket: "#{ENV["PAPERCLIP_S3_BUCKET_PREFIX"]}-#{Rails.env}" }

  validates :org, presence: true
  validates :name, presence: true
  validates_attachment :file, presence: true, content_type: { content_type: /\Aimage\/.*\Z/ }, size: { in: 0..10.megabytes }
  
end
