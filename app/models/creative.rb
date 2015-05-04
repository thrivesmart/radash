class Creative < ActiveRecord::Base
  VALID_LOCALES = ['af', 'ar', 'az', 'bg', 'bn', 'bs', 'ca', 'cs', 'cy', 'da', 'de', 'de-AT', 'de-CH', 'el', 'en', 'en-AU', 'en-CA', 'en-GB', 'en-IE', 'en-IN', 'en-NZ', 'en-US', 'en-ZA', 'eo', 'es', 'es-419', 'es-AR', 'es-CL', 'es-CO', 'es-CR', 'es-EC', 'es-MX', 'es-PA', 'es-PE', 'es-US', 'es-VE', 'et', 'eu', 'fa', 'fi', 'fr', 'fr-CA', 'fr-CH', 'gl', 'he', 'hi', 'hi-IN', 'hr', 'hu', 'id', 'is', 'it', 'it-CH', 'ja', 'km', 'kn', 'ko', 'lo', 'lt', 'lv', 'mk', 'mn', 'ms', 'nb', 'ne', 'nl', 'nn', 'or', 'pl', 'pt', 'pt-BR', 'rm', 'ro', 'ru', 'sk', 'sl', 'sr', 'sv', 'sw', 'ta', 'th', 'tl', 'tr', 'tt', 'uk', 'ur', 'uz', 'vi', 'wo', 'zh-CN', 'zh-HK', 'zh-TW', 'zh-YUE']
  belongs_to :org
  belongs_to :asset
  
  validates :org, presence: true
  
  def update_as_approved_by(u)
    if !self.approved_at.blank?
      errors.add(:approved_at, " - has already been approved") 
      return false
    end
    self.update_attributes(approved_at: Time.now, approver_name: u.username)
  end
end
