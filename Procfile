web: bundle exec puma -p ${PORT:="3000"}
worker: bundle exec sidekiq -q default -q http_service
mailhog: mailhog