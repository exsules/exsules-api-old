web: bundle exec puma -p ${PORT:="3000"} -C config/puma.rb
worker: bundle exec sidekiq -q default -q http_service -q mailers
mailhog: mailhog -invite-jim