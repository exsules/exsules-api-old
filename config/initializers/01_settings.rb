class Settings < Settingslogic
  source "#{Rails.root}/config/exsules.yml"
  namespace Rails.env
end

