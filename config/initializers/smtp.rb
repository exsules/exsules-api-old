#if !Rails.env.test?
  Rails.application.config.action_mailer.delivery_method = :smtp
  Rails.application.config.action_mailer.raise_delivery_errors = true unless Rails.env.production?

  Rails.application.config.action_mailer.smtp_settings = {
    address: "#{ENV['SMTP_HOST']}",
    port: ENV['SMTP_PORT'],
    user_name: "#{ENV['SMTP_USER']}",
    password: "#{ENV['SMTP_PASSWORD']}",
    domain: "#{ENV['SMTP_DOMAIN']}",
    authentication: "#{ENV['SMTP_AUTHENTICATION']}",
    enable_starttls_auto: ENV['SMTP_STARTSSL'],
    openssl_verify_mode: "#{ENV['SMTP_OPENSSL_VERIFY_MODE']}"
  }
#end