if Rails.env.production?
  $redis = Redis.new(host: 'dev.dvts6l.0001.euc1.cache.amazonaws.com', port: 6379, driver: :hiredis)
else
  $redis = Redis.new(host: 'localhost', port: 6379, driver: :hiredis)
end