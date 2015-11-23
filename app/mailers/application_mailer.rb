class ApplicationMailer < ActionMailer::Base
  default from: "noreply@#{Rails.application.config.action_mailer.smtp_settings[:domain]}"
  default "Message-ID" => ->(v){"<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@#{Rails.application.config.action_mailer.smtp_settings[:domain]}>"}
  #layout 'mailer'
end
