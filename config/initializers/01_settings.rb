class Settings < Settingslogic
  source "#{Rails.root}/config/social.yml"
  namespace Rails.env
end

