if Rails.env.development?
  Pusher.app_id = ENV['PUSHER_APP_ID']
  Pusher.key = ENV['PUSHER_KEY']
  Pusher.secret = ENV['PUSHER_SECRET']
  Pusher.logger = Rails.logger

else
  Pusher.app_id = "social"
  Pusher.key = "key"
  Pusher.secret = "Mysecret"
  require 'pusher-fake/support/base'
end
